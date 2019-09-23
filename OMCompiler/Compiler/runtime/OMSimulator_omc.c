/*
 * This file is part of OpenModelica.
 *
 * Copyright (c) 1998-2010, Linköpings University,
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

#if defined(__MINGW32__)
  #include <windows.h>
#else
  #include <dlfcn.h>
#endif

#include "meta_modelica.h"
#include "ModelicaUtilities.h"

#if defined WIN32
  static HINSTANCE OMSimulatorDLL = NULL;
  #define AddressOf GetProcAddress
#else
  static void * OMSimulatorDLL = NULL;
  #define AddressOf dlsym
#endif

// declare function signatures and pointers
typedef char* (*fnptr_oms_getVersion)();
static fnptr_oms_getVersion oms_getVersion = NULL;
typedef int (*fnptr_oms_setLogFile)(char*);
static fnptr_oms_setLogFile oms_setLogFile = NULL;

void resolveFunctionNames()
{
  oms_getVersion = (fnptr_oms_getVersion)AddressOf(OMSimulatorDLL, "oms_getVersion");
  oms_setLogFile = (fnptr_oms_setLogFile)AddressOf(OMSimulatorDLL, "oms_setLogFile");
  // TODO remaining function calls
}

void loadDLL()
{
  // check for OMSimulatorDLL instance for the first time this function called and load the library
  if(!OMSimulatorDLL)
  {
    #if defined WIN32
      OMSimulatorDLL = LoadLibrary("libOMSimulator.dll");
    #elif defined(__APPLE__)
      OMSimulatorDLL = dlopen("libOMSimulator.dylib",RTLD_LAZY|RTLD_DEEPBIND);
    #else
      OMSimulatorDLL = dlopen("libOMSimulator.so",RTLD_LAZY|RTLD_DEEPBIND);
    #endif
    if(!OMSimulatorDLL)
    {
      printf("Could not load the dynamic library libOMSimulator, Exiting the program\n");
      exit(0);
    }
    // resolve function signatures one time during initialization
    resolveFunctionNames();
  }
}

extern const char* OMSimulator_getVersion()
{
  loadDLL();
  if(!oms_getVersion)
  {
    printf("Could not Locate the Function oms_getVersion\n");
    exit(0);
  }
  char *res=oms_getVersion();
  return strcpy(ModelicaAllocateString(strlen(res)), res);
}

extern const int OMSimulator_setLogFile(char* filename)
{
  loadDLL();
  if(!oms_setLogFile)
  {
    printf("Could not Locate the Function oms_setLogFile\n");
    exit(0);
  }
  int status = oms_setLogFile(filename);
  return status;
}


