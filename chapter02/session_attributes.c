/**************************************************************************
******************* Troubleshooting Oracle Performance ********************
************************* http://top.antognini.ch *************************
***************************************************************************

File name...: session_attributes.c
Author......: Christian Antognini
Date........: August 2008
Description.: This C program shows how to set the client identifier, client
              information, module name, and action name through OCI.
Notes.......: -

You can send feedbacks or questions about this script to top@antognini.ch.

Changes:
DD.MM.YYYY Description
---------------------------------------------------------------------------

**************************************************************************/

#include <oci.h>

void checkerr(OCIError* err, sword status) 
{
  text errbuf[512];
  ub4 buflen;
  ub4 errcode;

  switch (status) 
  {
    case OCI_SUCCESS:
      break;
    case OCI_SUCCESS_WITH_INFO:
      printf("Error - OCI_SUCCESS_WITH_INFO\n");
      break;
    case OCI_NEED_DATA:
      printf("Error - OCI_NEED_DATA\n");
      break;
    case OCI_NO_DATA:
      printf("Error - OCI_NO_DATA\n");
      break;
    case OCI_ERROR:
      OCIErrorGet(err, (ub4)1, (text *)NULL, &errcode, errbuf, (ub4)sizeof(errbuf), (ub4)OCI_HTYPE_ERROR);
      printf("Error - %s\n", errbuf);
      break;
    case OCI_INVALID_HANDLE:
      printf("Error - OCI_INVALID_HANDLE\n");
      break;
    case OCI_STILL_EXECUTING:
      printf("Error - OCI_STILL_EXECUTE\n");
    break;
      case OCI_CONTINUE:
      printf("Error - OCI_CONTINUE\n");
      break;
    default:
      break;
  }
}

void parse_connect_string(char* connect_str, text username[30], text password[30], text dbname [30])
{
  username[0] = 0;
  password[0] = 0;
  dbname [0] = 0;

  char* to=username;

  while (*connect_str) 
  {
    if (*connect_str == '/') 
    {
      *to=0;
      to=password;
      connect_str++;
      continue;
    }
    if (*connect_str == '@') 
    {
      *to=0;
      to=dbname;
      connect_str++;
      continue;
    }
    *to=*connect_str;
    to++;
    connect_str++;
  }
  *to=0;
}

int main(int argc, char* argv[]) 
{
  OCIEnv* env = 0;
  OCIError* err = 0;
  OCIServer* srv = 0;
  OCISvcCtx* svc = 0;
  OCISession* ses = 0;
  OCIStmt* stm = 0;
  OCIDefine* def = 0;

  text username[30];
  text password[30];
  text dbname [30];
  text *sql = (text *)"SELECT sys_context('userenv', 'client_identifier'), sys_context('userenv','module'), sys_context('userenv','action') FROM dual";
  text client_id[64] = "helicon.antognini.ch";
  text module[48] = "mymodule";
  text action[32] = "myaction";

  sword r;

  if (argc < 2) 
  {
    printf("usage: %s username/password[@dbname]\n", argv[0]);
    exit (-1);
  }

  parse_connect_string(argv[1],username, password, dbname);

  r = OCIEnvCreate(&env, OCI_DEFAULT, 0, 0, 0, 0, 0, 0);
  if (r != OCI_SUCCESS) 
  {
    printf("OCIEnvCreate failed!\n");
    goto clean_up;
  }

  OCIHandleAlloc(env, (dvoid**)&err, OCI_HTYPE_ERROR, 0, 0);
  OCIHandleAlloc(env, (dvoid**)&srv, OCI_HTYPE_SERVER, 0, 0);
  OCIHandleAlloc(env, (dvoid**)&svc, OCI_HTYPE_SVCCTX, 0, 0);
  OCIHandleAlloc(env, (dvoid**)&ses, OCI_HTYPE_SESSION, 0, 0);

  r = OCIServerAttach(srv, err, dbname, strlen(dbname), (ub4) OCI_DEFAULT);
  if (r != OCI_SUCCESS) 
  {
    checkerr(err, r);
    goto clean_up;
  }

  OCIAttrSet(svc, OCI_HTYPE_SVCCTX, srv, 0, OCI_ATTR_SERVER, err);

  OCIAttrSet(ses, OCI_HTYPE_SESSION, username, strlen(username), OCI_ATTR_USERNAME, err);
  OCIAttrSet(ses, OCI_HTYPE_SESSION, password, strlen(password), OCI_ATTR_PASSWORD, err);

  OCIAttrSet(ses, OCI_HTYPE_SESSION, client_id, strlen(client_id), OCI_ATTR_CLIENT_IDENTIFIER, err);
  OCIAttrSet(ses, OCI_HTYPE_SESSION, module, strlen(module), OCI_ATTR_MODULE, err);
  OCIAttrSet(ses, OCI_HTYPE_SESSION, action, strlen(action), OCI_ATTR_ACTION, err);

  r = OCISessionBegin (svc, err, ses, OCI_CRED_RDBMS, OCI_DEFAULT);
  checkerr(err, r);

  OCIAttrSet(svc, OCI_HTYPE_SVCCTX, ses, 0, OCI_ATTR_SESSION, err);

  if (r = OCIHandleAlloc(env, (dvoid **)&stm, OCI_HTYPE_STMT, (CONST size_t)0, (dvoid **)0))
  {
    printf("OCIHandleAlloc failed: %i\n", r);
    checkerr(err, r);
    goto clean_up;
  }

  if (r = OCIStmtPrepare(stm, err, sql, strlen(sql), OCI_NTV_SYNTAX, OCI_DEFAULT))
  {
    printf ("OCIStmtPrepare failed: %i\n", r);
    checkerr(err, r);
    goto clean_up;
  }

  if (r = OCIDefineByPos (stm, &def, err, 1, client_id, sizeof(client_id), SQLT_STR, (dvoid *)0, (dvoid *)0, (dvoid *)0, OCI_DEFAULT))
  {
    printf ("OCIDefineByPos 1 failed: %i\n", r);
    checkerr(err, r);
    goto clean_up;
  }

  if (r = OCIDefineByPos (stm, &def, err, 2, module, sizeof(module), SQLT_STR, (dvoid *)0, (dvoid *)0, (dvoid *)0, OCI_DEFAULT))
  {
    printf ("OCIDefineByPos 2 failed: %i\n", r);
    checkerr(err, r);
    goto clean_up;
  }

  if (r = OCIDefineByPos (stm, &def, err, 3, action, sizeof(action), SQLT_STR, (dvoid *)0, (dvoid *)0, (dvoid *)0, OCI_DEFAULT))
  {
    printf ("OCIDefineByPos 3 failed: %i\n", r);
    checkerr(err, r);
    goto clean_up;
  }

  client_id[0] = 0;
  module[0] = 0;
  action[0] = 0;

  if (r = OCIStmtExecute(svc, stm, err, (ub4)1, (ub4)0, (OCISnapshot *)0, (OCISnapshot *)0, OCI_DEFAULT))
  {
    printf ("OCIStmtExecute failed: %i\n", r);
    checkerr(err, r);
    if (r != OCI_NO_DATA) 
      goto clean_up;
  }

  printf("client_id: %s\n", client_id);
  printf("module: %s\n", module);
  printf("action: %s\n", action);

  clean_up:
    if (env) OCIHandleFree(env, OCI_HTYPE_ENV );
    if (err) OCIHandleFree(err, OCI_HTYPE_ERROR );
    if (srv) OCIHandleFree(srv, OCI_HTYPE_SERVER);
    if (svc) OCIHandleFree(svc, OCI_HTYPE_SVCCTX);
    if (stm) OCIHandleFree(stm, OCI_HTYPE_STMT);

  OCITerminate(OCI_DEFAULT);

  return 0;
}
