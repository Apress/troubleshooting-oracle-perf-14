/**************************************************************************
******************* Troubleshooting Oracle Performance ********************
************************* http://top.antognini.ch *************************
***************************************************************************

File name...: row_prefetching.c
Author......: Christian Antognini
Date........: August 2008
Description.: These scripts provide examples of implementing row
              prefetching with OCI.
Notes.......: The table T created with row_prefetching.sql must exist.
Parameters. : username/password[@dbname]

You can send feedbacks or questions about this script to top@antognini.ch.

Changes:
DD.MM.YYYY Description
---------------------------------------------------------------------------

**************************************************************************/

#include <oci.h>

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
  OCIDefine* def = 0;

  text username[30];
  text password[30];
  text dbname [30];
  text *sql = (text *)"SELECT id, pad FROM t";
  int id;
  text pad[4000];

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

  ub4 rows = 100;
  OCIAttrSet(stm,                    // statement handle
             OCI_HTYPE_STMT,         // type of handle being modified
             &rows,                  // attribute.s value
             sizeof(rows),           // size of the attribute.s value
             OCI_ATTR_PREFETCH_ROWS, // attribute being set
             err);                   // error handle

  ub4 memory = 10240;
  OCIAttrSet(stm,                      // statement handle
             OCI_HTYPE_STMT,           // type of handle being modified
             &memory,                  // attribute.s value
             sizeof(memory),           // size of the attribute.s value
             OCI_ATTR_PREFETCH_MEMORY, // attribute being set
             err);                     // error handle

  if (r = OCIDefineByPos(stm, &def, err, 1, &id, sizeof(id), SQLT_INT, 0, 0, 0, OCI_DEFAULT) != OCI_SUCCESS)
  {
    checkerr(err, "OCIDefineByPos", r);
    goto clean_up;
  }

  if (r = OCIDefineByPos(stm, &def, err, 2, pad, sizeof(pad), SQLT_STR, 0, 0, 0, OCI_DEFAULT) != OCI_SUCCESS)
  {
    checkerr(err, "OCIDefineByPos", r);
    goto clean_up;
  }

  if (r = OCIStmtExecute(svc, stm, err, 0, 0, 0, 0, OCI_DEFAULT) != OCI_SUCCESS)
  {
    checkerr(err, "OCIStmtExecute", r);
    goto clean_up;
  }

  while (r = OCIStmtFetch2(stm, err, 1, OCI_FETCH_NEXT, 0, OCI_DEFAULT) == OCI_SUCCESS)
  {
    //printf("%i - %s\n", id, pad);
  }

  if (r = OCIStmtRelease(stm, err, NULL, 0, OCI_DEFAULT) != OCI_SUCCESS)
  {
    checkerr(err, "OCIStmtFetch2", r);
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
