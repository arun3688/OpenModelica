/*
 * This file is part of OpenModelica.
 *
 * Copyright (c) 1998-2014, Open Source Modelica Consortium (OSMC),
 * c/o Linköpings universitet, Department of Computer and Information Science,
 * SE-58183 Linköping, Sweden.
 *
 * All rights reserved.
 *
 * THIS PROGRAM IS PROVIDED UNDER THE TERMS OF GPL VERSION 3 LICENSE OR
 * THIS OSMC PUBLIC LICENSE (OSMC-PL) VERSION 1.2.
 * ANY USE, REPRODUCTION OR DISTRIBUTION OF THIS PROGRAM CONSTITUTES
 * RECIPIENT'S ACCEPTANCE OF THE OSMC PUBLIC LICENSE OR THE GPL VERSION 3,
 * ACCORDING TO RECIPIENTS CHOICE.
 *
 * The OpenModelica software and the Open Source Modelica
 * Consortium (OSMC) Public License (OSMC-PL) are obtained
 * from OSMC, either from the above address,
 * from the URLs: http://www.ida.liu.se/projects/OpenModelica or
 * http://www.openmodelica.org, and in the OpenModelica distribution.
 * GNU version 3 is obtained from: http://www.gnu.org/copyleft/gpl.html.
 *
 * This program is distributed WITHOUT ANY WARRANTY; without
 * even the implied warranty of  MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE, EXCEPT AS EXPRESSLY SET FORTH
 * IN THE BY RECIPIENT SELECTED SUBSIDIARY LICENSE CONDITIONS OF OSMC-PL.
 *
 * See the full OSMC Public License conditions for more details.
 *
 */

encapsulated package OMSimulator
" file:         OMSimulator.mo
  package:     OMSimulator
  description: This file contains OMSimulator wrapper functions which are implemented in  C and Linked through DLL.
  "

public function oms_getVersion "Returns the version number of this release"
  output String outString;
  //external "C" outString=oms_getVersion() annotation(Library = "omcruntime");
  external "C" outString=OMSimulator_getVersion() annotation(Library = "omcruntime");
end oms_getVersion;

public function oms_setLogFile "set the LogFile name defined by user"
  input String filename;
  output Integer status;
  //external "C" status=oms_setLogFile(filename) annotation(Library = "omcruntime");
  external "C" status=OMSimulator_setLogFile(filename) annotation(Library = "omcruntime");
end oms_setLogFile;

// TODO List of other OMSimulator API

annotation(__OpenModelica_Interface="util");
end OMSimulator;
