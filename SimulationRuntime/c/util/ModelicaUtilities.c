/*
 * This file is part of OpenModelica.
 *
 * Copyright (c) 1998-CurrentYear, Linköping University,
 * Department of Computer and Information Science,
 * SE-58183 Linköping, Sweden.
 *
 * All rights reserved.
 *
 * THIS PROGRAM IS PROVIDED UNDER THE TERMS OF GPL VERSION 3
 * AND THIS OSMC PUBLIC LICENSE (OSMC-PL).
 * ANY USE, REPRODUCTION OR DISTRIBUTION OF THIS PROGRAM CONSTITUTES RECIPIENT'S
 * ACCEPTANCE OF THE OSMC PUBLIC LICENSE.
 *
 * The OpenModelica software and the Open Source Modelica
 * Consortium (OSMC) Public License (OSMC-PL) are obtained
 * from Linköping University, either from the above address,
 * from the URLs: http://www.ida.liu.se/projects/OpenModelica or
 * http://www.openmodelica.org, and in the OpenModelica distribution.
 * GNU version 3 is obtained from: http://www.gnu.org/copyleft/gpl.html.
 *
 * This program is distributed WITHOUT ANY WARRANTY; without
 * even the implied warranty of  MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE, EXCEPT AS EXPRESSLY SET FORTH
 * IN THE BY RECIPIENT SELECTED SUBSIDIARY LICENSE CONDITIONS
 * OF OSMC-PL.
 *
 * See the full OSMC Public License conditions for more details.
 *
 */

#include "ModelicaUtilities.h"
#include "modelica_string.h"

#include "gc.h"

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include "omc_error.h"

void ModelicaMessage(const char* string) {
  ModelicaFormatMessage("%s", string);
}

extern void ModelicaVFormatMessage(const char*string, va_list args) {
  vfprintf(stdout, string, args);
  fflush(stdout);
}

void ModelicaFormatMessage(const char* string,...) {
  va_list args;
  va_start(args, string);
  ModelicaVFormatMessage(string, args);
  va_end(args);
}

void ModelicaError(const char* string) {
  fputs(string, stderr);
  fflush(stderr);
  omc_throw(NULL);
}

void ModelicaVFormatError(const char*string, va_list args) {
  vfprintf(stderr, string, args);
  fflush(stderr);
  omc_throw(NULL);
}

void ModelicaFormatError(const char* string, ...) {
  va_list args;
  va_start(args, string);
  ModelicaVFormatError(string, args);
  va_end(args);
}

char* ModelicaAllocateString(size_t len) {
  char *res = ModelicaAllocateStringWithErrorReturn(len);
  if(!res)
    ModelicaFormatError("%s:%d: ModelicaAllocateString failed", __FILE__, __LINE__);
  return res;
}

char* ModelicaAllocateStringWithErrorReturn(size_t len) {
  char *res = omc_alloc_interface.malloc_string(len+1);
  if (res != NULL) {
    res[len] = '\0';
  }
  return res;
}
