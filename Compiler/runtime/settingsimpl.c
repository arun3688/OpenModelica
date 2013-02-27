/*
 * This file is part of OpenModelica.
 *
 * Copyright (c) 1998-2011, Linköpings University,
 * Department of Computer and Information Science,
 * SE-58183 Linköping, Sweden.
 *
 * All rights reserved.
 *
 * THIS PROGRAM IS PROVIDED UNDER THE TERMS OF THIS OSMC PUBLIC
 * LICENSE (OSMC-PL). ANY USE, REPRODUCTION OR DISTRIBUTION OF
 * THIS PROGRAM CONSTITUTES RECIPIENT'S ACCEPTANCE OF THE OSMC
 * PUBLIC LICENSE.
 *
 * The OpenModelica software and the Open Source Modelica
 * Consortium (OSMC) Public License (OSMC-PL) are obtained
 * from Linköpings University, either from the above address,
 * from the URL: http://www.ida.liu.se/projects/OpenModelica
 * and in the OpenModelica distribution.
 *
 * This program is distributed  WITHOUT ANY WARRANTY; without
 * even the implied warranty of  MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE, EXCEPT AS EXPRESSLY SET FORTH
 * IN THE BY RECIPIENT SELECTED SUBSIDIARY LICENSE CONDITIONS
 * OF OSMC-PL.
 *
 * See the full OSMC Public License conditions for more details.
 *
 */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "config.h"

/* malloc.h is in sys in Mac OS */
#ifdef __APPLE_CC__
#include <sys/malloc.h>
#else /* Linux or Windows here */
#include <malloc.h>
#endif

#if defined(_MSC_VER) || defined(__MINGW32__)
#else
#include <unistd.h>
#include <pwd.h>
#endif

#ifdef WIN32
#define WIN32_LEAN_AND_MEAN
#include <Windows.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

static char* compileCommand = 0;
static char* compilePath = 0;
static char* tempDirectoryPath = 0;
static int   echo = 1; //true

extern char* _replace(char* source_str,char* search_str,char* replace_str); //Defined in systemimpl.c
extern int SystemImpl__directoryExists(const char*);

static char* winPath = NULL;

// Do not free or modify the returned variable. It's part of the environment!
const char* SettingsImpl__getInstallationDirectoryPath() {
  const char *path = getenv("OPENMODELICAHOME");
  int i = 0;
  if (path == NULL)
    return CONFIG_DEFAULT_OPENMODELICAHOME; // On Windows, this is NULL; on Unix it is the configured --prefix
#if defined(__MINGW32__) || defined(_MSC_VER)
  /* adrpo: translate this to forward slashes! */
  /* already set, set it only once! */
  if (winPath != NULL)
    return (const char*)winPath;

  /* duplicate the path */
  winPath = strdup(path);

  /* ?? not enough memory for duplication */
  if (!winPath)
    return path;

  /* convert \\ to / */
  while(winPath[i] != '\0')
  {
    if (winPath[i] == '\\') winPath[i] = '/';
    i++;
  }
  return (const char*)winPath;
#endif
  return path;
}

char* winLibPath = NULL;

// Do not free the returned variable. It's malloc'ed
char* SettingsImpl__getModelicaPath(int runningTestsuite) {
  const char *path = getenv("OPENMODELICALIBRARY");
  int i = 0;
  if (path == NULL) {
    // By default, this is <omhome>/lib/omlibrary/
    const char *omhome = SettingsImpl__getInstallationDirectoryPath();
    if (omhome == NULL)
      return NULL;
    int lenOmhome = strlen(omhome);
    char *buffer;
#if !(defined(_MSC_VER) || defined(__MINGW32__))
    const char *homePath = getenv("HOME");
    if (homePath == NULL)
      homePath = getpwuid(getuid())->pw_dir;
    if (homePath == NULL || runningTestsuite) {
#endif
      buffer = (char*) malloc(lenOmhome+15);
      snprintf(buffer,lenOmhome+15,"%s/lib/omlibrary",omhome);
#if !(defined(_MSC_VER) || defined(__MINGW32__))
    } else {
      int lenHome = strlen(homePath);
      buffer = (char*) malloc(lenOmhome+lenHome+41);
      snprintf(buffer,lenOmhome+lenHome+41,"%s/lib/omlibrary:%s/.openmodelica/libraries/",omhome,homePath);
    }
#endif
    return buffer;
  }

#if defined(__MINGW32__) || defined(_MSC_VER)
  /* adrpo: translate this to forward slashes! */
  /* duplicate the path */
  winLibPath = strdup(path);

  /* ?? not enough memory for duplication */
  if (!winLibPath)
    return strdup(path);

  /* convert \\ to / */
  while(winLibPath[i] != '\0')
  {
    if (winLibPath[i] == '\\') winLibPath[i] = '/';
    i++;
  }
  return winLibPath;
#endif

  return strdup(path);
}

static const char* SettingsImpl__getCompileCommand()
{
  if (compileCommand == NULL) {
    // Get a default command
    const char *res = getenv("MC_DEFAULT_COMPILE_CMD");
    if (res == NULL)
      return DEFAULT_CXX;
    return res;
  }
  return compileCommand;
}

extern void SettingsImpl__setCompileCommand(const char *command)
{
  if(compileCommand)
    free(compileCommand);
  compileCommand = strdup(command);
}

static const char* SettingsImpl__getCompilePath()
{
  if (compilePath == NULL) {
    // Get a default command
    const char *res = getenv("MC_DEFAULT_COMPILE_PATH");
    if (res == NULL)
      return "";
    return res;
  }
  return compilePath;
}

extern void SettingsImpl__setCompilePath(const char *path) {
  if(compilePath)
    free(compilePath);
  compilePath = strdup(path);
}

static void commonSetEnvVar(const char *var, const char *value)
{
  int lenVar = strlen(var);
  int lenVal = strlen(value);
  char* command = (char*) malloc(lenVar+lenVal+2);
  assert(command != NULL);
  /* create a str of the form: <VAR>=<VALUE>*/
  snprintf(command, lenVar+lenVal+2, "%s=%s", var, value);
  command[lenVar+lenVal+1]='\0';
  /* set the env-var to created string this is useful when scripts and clients started by omc wants to use OPENMODELICAHOME*/
  assert(putenv(command) == 0); // adrpo: in Linux there is not _putenv if( _putenv(omhome) != 0)
#if defined(WIN32)
  /* Only free on windows, in Linux the environment is taking over the ownership of the ptr */
  free(command);
#endif
}

extern void SettingsImpl__setInstallationDirectoryPath(const char *value)
{
  commonSetEnvVar("OPENMODELICAHOME",value);
}

extern void SettingsImpl__setModelicaPath(const char *value)
{
  commonSetEnvVar("OPENMODELICALIBRARY",value);
}

extern void SettingsImpl__setTempDirectoryPath(const char *path)
{
  if (tempDirectoryPath)
    free(tempDirectoryPath);
  tempDirectoryPath = strdup(path);
}

extern const char* SettingsImpl__getTempDirectoryPath()
{
  if (tempDirectoryPath == NULL) {
  // On windows, set Temp directory path to Temp directory as returned by GetTempPath,
  // which is usually TMP or TEMP or windows catalogue.
  #ifdef WIN32
    int numChars;
    char* str,str1;
    char tempDirectory[1024];
      //extract the temp path
    numChars= GetTempPath(1024, tempDirectory);
    if (numChars == 1024 || numChars == 0) {
      fprintf(stderr, "Error setting temppath in Kernel\n");
      exit(1);
    } else {
      // Must do replacement in two steps, since the _replace function can not have similar source as target.
      str = _replace(tempDirectory, (char*)"\\", (char*)"/");
      tempDirectoryPath= _replace(str, (char*)"/", (char*)"\\\\");
      free(str);
    }
  #else
    const char* str = getenv("TMPDIR");
    if (str == NULL)
      str = strdup("/tmp");
    tempDirectoryPath = strdup(str);
  #endif
  }
  return tempDirectoryPath;
}

#ifdef __cplusplus
}
#endif
