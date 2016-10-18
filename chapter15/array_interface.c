/**************************************************************************
******************* Troubleshooting Oracle Performance ********************
************************* http://top.antognini.ch *************************
***************************************************************************

File name...: array_interface.c
Author......: Christian Antognini
Date........: August 2008
Description.: These scripts provide examples of implementing the array
              interface with OCI.
Notes.......: The table T created with array_interface.sql must exist.
Parameters. : username/password[@dbname]

You can send feedbacks or questions about this script to top@antognini.ch.

Changes:
DD.MM.YYYY Description
---------------------------------------------------------------------------

**************************************************************************/

#include <oci.h>

#define ROWS 1000

void checkerr(OCIError* err, char* msg, sword status) 
{
  text errbuf[512];
  ub4 buflen;
  ub4 errcode;

  switch (status) 
  {
    case OCI_SUCCESS:
      break;
    default:
      OCIErrorGet(err, 1, NULL, &errcode, errbuf, sizeof(errbuf), OCI_HTYPE_ERROR);
      printf("Error calling %s - %s\n", msg, errbuf);
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
  OCISvcCtx* svc = 0;
  OCIStmt* stm = 0;
  OCIBind* bnd = 0;

  text username[30];
  text password[30];
  text dbname [30];
  text *sql = (text *)"INSERT INTO T VALUES (:id, :pad)";
  int id[ROWS];
  char pad[ROWS][4000];

  sword r;

  if (argc != 2) 
  {
    printf("usage: %s username/password[@dbname]\n", argv[0]);
    exit (-1);
  }

  parse_connect_string(argv[1],username, password, dbname);

  OCIEnvCreate(&env, OCI_DEFAULT, 0, 0, 0, 0, 0, 0);
  OCIHandleAlloc(env, (dvoid *)&err, OCI_HTYPE_ERROR, 0, 0);

  if (r = OCILogon2(env, err, &svc, username, strlen(username), password, strlen(password), dbname, strlen(dbname), OCI_DEFAULT) != OCI_SUCCESS) 
  {
    checkerr(err, "OCILogon2", r);
    goto clean_up;
  }

  if (r = OCIStmtPrepare2(svc, (OCIStmt **)&stm, err, sql, strlen(sql), NULL, 0, OCI_NTV_SYNTAX, OCI_DEFAULT) != OCI_SUCCESS)
  {
    checkerr(err, "OCIStmtPrepare2", r);
    goto clean_up;
  }


  int i;
  for (i=0 ; i<ROWS ; i++)
  {
    id[i] = i+1;
    strcpy(pad[i], "******************************************************************************************");
  }

  if (r = OCIBindByPos(stm, &bnd, err, 1, &id[0], sizeof(id[0]), SQLT_INT, 0, 0, 0, 0, 0, OCI_DEFAULT) != OCI_SUCCESS)
  {
    checkerr(err, "OCIBindByPos", r);
    goto clean_up;
  }

  if (r = OCIBindByPos(stm, &bnd, err, 2, pad[0], sizeof(pad[0]), SQLT_STR, 0, 0, 0, 0, 0, OCI_DEFAULT) != OCI_SUCCESS)
  {
    checkerr(err, "OCIBindByPos", r);
    goto clean_up;
  }

  if (r = OCIStmtExecute(svc, stm, err, ROWS, 0, 0, 0, OCI_DEFAULT) != OCI_SUCCESS)
  {
    checkerr(err, "OCIStmtExecute", r);
    goto clean_up;
  }

  if (r = OCIStmtRelease(stm, err, NULL, 0, OCI_DEFAULT) != OCI_SUCCESS)
  {
    checkerr(err, "OCIStmtRelease", r);
    goto clean_up;
  }

  if (r = OCILogoff(svc, err) != OCI_SUCCESS)
  {
    checkerr(err, "OCILogoff", r);
  }

  clean_up:
    if (stm) OCIHandleFree(stm, OCI_HTYPE_STMT);
    if (err) OCIHandleFree(err, OCI_HTYPE_ERROR);
    if (svc) OCIHandleFree(svc, OCI_HTYPE_SVCCTX);
    if (env) OCIHandleFree(env, OCI_HTYPE_ENV);

  return 0;
}


