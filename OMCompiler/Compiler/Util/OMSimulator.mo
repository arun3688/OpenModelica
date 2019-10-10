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
public function statusToString
  input Integer status;
  output String outstring;
algorithm
  if(status==0) then
    outstring:="ok";
  elseif(status==1) then
    outstring:="warning";
  elseif(status==2) then
    outstring:="discard";
  elseif(status==3) then
    outstring:="error";
  elseif(status==4) then
    outstring:="fatal";
  elseif(status==5) then
    outstring:="pending";
  else
    outstring:="unknown_status";
  end if;
end statusToString;

public function oms_getVersion "Returns the version number of this release"
  output String outString;
  external "C" outString = OMSimulator_oms_getVersion() annotation(Library = "omcruntime");
end oms_getVersion;

function oms_addBus
  input String cref;
  output Integer status;
  external "C" status = OMSimulator_oms_addBus(cref) annotation(Library = "omcruntime");
end oms_addBus;

function oms_addConnection
  input String crefA;
  input String crefB;
  output Integer status;
  external "C" status = OMSimulator_oms_addConnection(crefA,crefB) annotation(Library = "omcruntime");
end oms_addConnection;

function oms_addConnector
  input String cref;
  input Integer causality;
  input Integer type_;
  output Integer status;
  external "C" status = OMSimulator_oms_addConnector(cref,causality,type_) annotation(Library = "omcruntime");
end oms_addConnector;

function oms_addConnectorToBus
  input String busCref;
  input String connectorCref;
  output Integer status;
  external "C" status = OMSimulator_oms_addConnectorToBus(busCref,connectorCref) annotation(Library = "omcruntime");
end oms_addConnectorToBus;

function oms_addConnectorToTLMBus
  input String busCref;
  input String connectorCref;
  input String type_;
  output Integer status;
  external "C" status = OMSimulator_oms_addConnectorToTLMBus(busCref,connectorCref,type_) annotation(Library = "omcruntime");
end oms_addConnectorToTLMBus;

function oms_addDynamicValueIndicator
  input String signal;
  input String lower;
  input String upper;
  input Real stepSize;
  output Integer status;
  external "C" status = OMSimulator_oms_addDynamicValueIndicator(signal,lower,upper,stepSize) annotation(Library = "omcruntime");
end oms_addDynamicValueIndicator;

function oms_addEventIndicator
  input String signal;
  output Integer status;
  external "C" status = OMSimulator_oms_addEventIndicator(signal) annotation(Library = "omcruntime");
end oms_addEventIndicator;

function oms_addExternalModel
  input String cref;
  input String path;
  input String startscript;
  output Integer status;
  external "C" status = OMSimulator_oms_addExternalModel(cref,path,startscript) annotation(Library = "omcruntime");
end oms_addExternalModel;

function oms_addSignalsToResults
  input String cref;
  input String regex;
  output Integer status;
  external "C" status = OMSimulator_oms_addSignalsToResults(cref,regex) annotation(Library = "omcruntime");
end oms_addSignalsToResults;

function oms_addStaticValueIndicator
  input String signal;
  input Real lower;
  input Real upper;
  input Real stepSize;
  output Integer status;
  external "C" status = OMSimulator_oms_addStaticValueIndicator(signal,lower,upper,stepSize) annotation(Library = "omcruntime");
end oms_addStaticValueIndicator;

function oms_addSubModel
  input String cref;
  input String fmuPath;
  output Integer status;
  external "C" status = OMSimulator_oms_addSubModel(cref,fmuPath) annotation(Library = "omcruntime");
end oms_addSubModel;

function oms_addSystem
  input String cref;
  input Integer type_;
  output Integer status;
  external "C" status = OMSimulator_oms_addSystem(cref,type_) annotation(Library = "omcruntime");
end oms_addSystem;

function oms_addTimeIndicator
  input String signal;
  output Integer status;
  external "C" status = OMSimulator_oms_addTimeIndicator(signal) annotation(Library = "omcruntime");
end oms_addTimeIndicator;

function oms_addTLMBus
  input String cref;
  input Integer domain;
  input Integer dimensions;
  input Integer interpolation;
  output Integer status;
  external "C" status = OMSimulator_oms_addTLMBus(cref,domain,dimensions,interpolation) annotation(Library = "omcruntime");
end oms_addTLMBus;

function oms_addTLMConnection
  input String crefA;
  input String crefB;
  input Real delay;
  input Real alpha;
  input Real linearimpedance;
  input Real angularimpedance;
  output Integer status;
  external "C" status = OMSimulator_oms_addTLMConnection(crefA,crefB,delay,alpha,linearimpedance,angularimpedance) annotation(Library = "omcruntime");
end oms_addTLMConnection;

function oms_cancelSimulation_asynchronous
  input String cref;
  output Integer status;
  external "C" status = OMSimulator_oms_cancelSimulation_asynchronous(cref) annotation(Library = "omcruntime");
end oms_cancelSimulation_asynchronous;

function oms_compareSimulationResults
  input String filenameA;
  input String filenameB;
  input String var;
  input Real relTol;
  input Real absTol;
  output Integer status;
  external "C" status = OMSimulator_oms_compareSimulationResults(filenameA,filenameB,var,relTol,absTol) annotation(Library = "omcruntime");
end oms_compareSimulationResults;

function oms_copySystem
  input String source;
  input String target;
  output Integer status;
  external "C" status = OMSimulator_oms_copySystem(source,target) annotation(Library = "omcruntime");
end oms_copySystem;

function oms_delete
  input String cref;
  output Integer status;
  external "C" status = OMSimulator_oms_delete(cref) annotation(Library = "omcruntime");
end oms_delete;

function oms_deleteConnection
  input String crefA;
  input String crefB;
  output Integer status;
  external "C" status = OMSimulator_oms_deleteConnection(crefA,crefB) annotation(Library = "omcruntime");
end oms_deleteConnection;

function oms_deleteConnectorFromBus
  input String busCref;
  input String connectorCref;
  output Integer status;
  external "C" status = OMSimulator_oms_deleteConnectorFromBus(busCref,connectorCref) annotation(Library = "omcruntime");
end oms_deleteConnectorFromBus;

function oms_deleteConnectorFromTLMBus
  input String busCref;
  input String connectorCref;
  output Integer status;
  external "C" status = OMSimulator_oms_deleteConnectorFromTLMBus(busCref,connectorCref) annotation(Library = "omcruntime");
end oms_deleteConnectorFromTLMBus;

function oms_export
  input String cref;
  input String filename;
  output Integer status;
  external "C" status = OMSimulator_oms_export(cref,filename) annotation(Library = "omcruntime");
end oms_export;

function oms_exportDependencyGraphs
  input String cref;
  input String initialization;
  input String simulation;
  output Integer status;
  external "C" status = OMSimulator_oms_exportDependencyGraphs(cref,initialization,simulation) annotation(Library = "omcruntime");
end oms_exportDependencyGraphs;

function oms_extractFMIKind
  input String filename;
  output Integer status;
  output Integer kind;
  external "C" status = OMSimulator_oms_extractFMIKind(filename,kind) annotation(Library = "omcruntime");
end oms_extractFMIKind;

function oms_getBoolean
  input String cref;
  output Integer status;
  output Boolean value;
  external "C" status = OMSimulator_oms_getBoolean(cref,value) annotation(Library = "omcruntime");
end oms_getBoolean;

function oms_getFixedStepSize
  input String cref;
  output Integer status;
  output Real stepSize;
  external "C" status = OMSimulator_oms_getFixedStepSize(cref,stepSize) annotation(Library = "omcruntime");
end oms_getFixedStepSize;

function oms_getInteger
  input String cref;
  output Integer status;
  output Integer value;
  external "C" status = OMSimulator_oms_getInteger(cref,value) annotation(Library = "omcruntime");
end oms_getInteger;

function oms_getModelState
  input String cref;
  output Integer status;
  output Integer modelState;
  external "C" status = OMSimulator_oms_getModelState(cref,modelState) annotation(Library = "omcruntime");
end oms_getModelState;

function oms_getReal
  input String cref;
  output Integer status;
  output Real value;
  external "C" status = OMSimulator_oms_getReal(cref,value) annotation(Library = "omcruntime");
end oms_getReal;

function oms_getSolver
  input String cref;
  output Integer status;
  output Integer solver;
  external "C" status = OMSimulator_oms_getSolver(cref,solver) annotation(Library = "omcruntime");
end oms_getSolver;

function oms_getStartTime
  input String cref;
  output Integer status;
  output Real startTime;
  external "C" status = OMSimulator_oms_getStartTime(cref,startTime) annotation(Library = "omcruntime");
end oms_getStartTime;

function oms_getStopTime
  input String cref;
  output Integer status;
  output Real stopTime;
  external "C" status = OMSimulator_oms_getStopTime(cref,stopTime) annotation(Library = "omcruntime");
end oms_getStopTime;

function oms_getSubModelPath
  input String cref;
  output Integer status;
  output String path;
  external "C" status = OMSimulator_oms_getSubModelPath(cref,path) annotation(Library = "omcruntime");
end oms_getSubModelPath;

function oms_getSystemType
  input String cref;
  output Integer status;
  output Integer type_;
  external "C" status = OMSimulator_oms_getSystemType(cref,type_) annotation(Library = "omcruntime");
end oms_getSystemType;

function oms_getTolerance
  input String cref;
  output Integer status;
  output Real absoluteTolerance;
  output Real relativeTolerance;
  external "C" status = OMSimulator_oms_getTolerance(cref,absoluteTolerance,relativeTolerance) annotation(Library = "omcruntime");
end oms_getTolerance;

function oms_getVariableStepSize
  input String cref;
  output Integer status;
  output Real initialStepSize;
  output Real minimumStepSize;
  output Real maximumStepSize;
  external "C" status = OMSimulator_oms_getVariableStepSize(cref,initialStepSize,minimumStepSize,maximumStepSize) annotation(Library = "omcruntime");
end oms_getVariableStepSize;

function oms_faultInjection
  input String signal;
  input Integer faultType;
  input Real faultValue;
  output Integer status;
  external "C" status = OMSimulator_oms_faultInjection(signal,faultType,faultValue) annotation(Library = "omcruntime");
end oms_faultInjection;

function oms_importFile
  input String filename;
  input String cref;
  output Integer status;
  external "C" status = OMSimulator_oms_importFile(filename,cref) annotation(Library = "omcruntime");
end oms_importFile;

function oms_initialize
  input String cref;
  output Integer status;
  external "C" status = OMSimulator_oms_initialize(cref) annotation(Library = "omcruntime");
end oms_initialize;

function oms_instantiate
  input String cref;
  output Integer status;
  external "C" status = OMSimulator_oms_instantiate(cref) annotation(Library = "omcruntime");
end oms_instantiate;

function oms_list
  input String cref;
  output Integer status;
  output String contents;
  external "C" status = OMSimulator_oms_list(cref,contents) annotation(Library = "omcruntime");
end oms_list;

function oms_listUnconnectedConnectors
  input String cref;
  output Integer status;
  output String contents;
  external "C" status = OMSimulator_oms_listUnconnectedConnectors(cref,contents) annotation(Library = "omcruntime");
end oms_listUnconnectedConnectors;

function oms_loadSnapshot
  input String cref;
  input String snapshot;
  output Integer status;
  external "C" status = OMSimulator_oms_loadSnapshot(cref,snapshot) annotation(Library = "omcruntime");
end oms_loadSnapshot;

function oms_newModel
  input String cref;
  output Integer status;
  external "C" status = OMSimulator_oms_newModel(cref) annotation(Library = "omcruntime");
end oms_newModel;

function oms_parseModelName
  input String contents;
  output Integer status;
  output String cref;
  external "C" status = OMSimulator_oms_parseModelName(contents,cref) annotation(Library = "omcruntime");
end oms_parseModelName;

function oms_removeSignalsFromResults
  input String cref;
  input String regex;
  output Integer status;
  external "C" status = OMSimulator_oms_removeSignalsFromResults(cref,regex) annotation(Library = "omcruntime");
end oms_removeSignalsFromResults;

function oms_rename
  input String cref;
  input String newCref;
  output Integer status;
  external "C" status = OMSimulator_oms_rename(cref,newCref) annotation(Library = "omcruntime");
end oms_rename;

function oms_reset
  input String cref;
  output Integer status;
  external "C" status = OMSimulator_oms_reset(cref) annotation(Library = "omcruntime");
end oms_reset;

function oms_RunFile
  input String filename;
  output Integer status;
  external "C" status = OMSimulator_oms_RunFile(filename) annotation(Library = "omcruntime");
end oms_RunFile;

function oms_setBoolean
  input String cref;
  input Boolean value;
  output Integer status;
  external "C" status = OMSimulator_oms_setBoolean(cref,value) annotation(Library = "omcruntime");
end oms_setBoolean;

function oms_setCommandLineOption
  input String cmd;
  output Integer status;
  external "C" status = OMSimulator_oms_setCommandLineOption(cmd) annotation(Library = "omcruntime");
end oms_setCommandLineOption;

function oms_setFixedStepSize
  input String cref;
  input Real stepSize;
  output Integer status;
  external "C" status = OMSimulator_oms_setFixedStepSize(cref,stepSize) annotation(Library = "omcruntime");
end oms_setFixedStepSize;

function oms_setInteger
  input String cref;
  input Integer value;
  output Integer status;
  external "C" status = OMSimulator_oms_setInteger(cref,value) annotation(Library = "omcruntime");
end oms_setInteger;

function oms_setLogFile
  input String filename;
  output Integer status;
  external "C" status = OMSimulator_oms_setLogFile(filename) annotation(Library = "omcruntime");
end oms_setLogFile;

function oms_setLoggingInterval
  input String cref;
  input Real loggingInterval;
  output Integer status;
  external "C" status = OMSimulator_oms_setLoggingInterval(cref,loggingInterval) annotation(Library = "omcruntime");
end oms_setLoggingInterval;

function oms_setLoggingLevel
  input Integer logLevel;
  output Integer status;
  external "C" status = OMSimulator_oms_setLoggingLevel(logLevel) annotation(Library = "omcruntime");
end oms_setLoggingLevel;

function oms_setReal
  input String cref;
  input Real value;
  output Integer status;
  external "C" status = OMSimulator_oms_setReal(cref,value) annotation(Library = "omcruntime");
end oms_setReal;

function oms_setRealInputDerivative
  input String cref;
  input Real value;
  output Integer status;
  external "C" status = OMSimulator_oms_setRealInputDerivative(cref,value) annotation(Library = "omcruntime");
end oms_setRealInputDerivative;

function oms_setResultFile
  input String cref;
  input String filename;
  input Integer bufferSize;
  output Integer status;
  external "C" status = OMSimulator_oms_setResultFile(cref,filename,bufferSize) annotation(Library = "omcruntime");
end oms_setResultFile;

function oms_setSignalFilter
  input String cref;
  input String regex;
  output Integer status;
  external "C" status = OMSimulator_oms_setSignalFilter(cref,regex) annotation(Library = "omcruntime");
end oms_setSignalFilter;

function oms_setSolver
  input String cref;
  input Integer solver;
  output Integer status;
  external "C" status = OMSimulator_oms_setSolver(cref,solver) annotation(Library = "omcruntime");
end oms_setSolver;

function oms_setStartTime
  input String cref;
  input Real startTime;
  output Integer status;
  external "C" status = OMSimulator_oms_setStartTime(cref,startTime) annotation(Library = "omcruntime");
end oms_setStartTime;

function oms_setStopTime
  input String cref;
  input Real stopTime;
  output Integer status;
  external "C" status = OMSimulator_oms_setStopTime(cref,stopTime) annotation(Library = "omcruntime");
end oms_setStopTime;

function oms_setTempDirectory
  input String newTempDir;
  output Integer status;
  external "C" status = OMSimulator_oms_setTempDirectory(newTempDir) annotation(Library = "omcruntime");
end oms_setTempDirectory;

function oms_setTolerance
  input String cref;
  input Real absoluteTolerance;
  input Real relativeTolerance;
  output Integer status;
  external "C" status = OMSimulator_oms_setTolerance(cref,absoluteTolerance,relativeTolerance) annotation(Library = "omcruntime");
end oms_setTolerance;

function oms_setVariableStepSize
  input String cref;
  input Real initialStepSize;
  input Real minimumStepSize;
  input Real maximumStepSize;
  output Integer status;
  external "C" status = OMSimulator_oms_setVariableStepSize(cref,initialStepSize,minimumStepSize,maximumStepSize) annotation(Library = "omcruntime");
end oms_setVariableStepSize;

function oms_setWorkingDirectory
  input String newWorkingDir;
  output Integer status;
  external "C" status = OMSimulator_oms_setWorkingDirectory(newWorkingDir) annotation(Library = "omcruntime");
end oms_setWorkingDirectory;

function oms_simulate
  input String cref;
  output Integer status;
  external "C" status = OMSimulator_oms_simulate(cref) annotation(Library = "omcruntime");
end oms_simulate;

function oms_stepUntil
  input String cref;
  input Real stopTime;
  output Integer status;
  external "C" status = OMSimulator_oms_stepUntil(cref,stopTime) annotation(Library = "omcruntime");
end oms_stepUntil;

function oms_terminate
  input String cref;
  output Integer status;
  external "C" status = OMSimulator_oms_terminate(cref) annotation(Library = "omcruntime");
end oms_terminate;


/*
type oms_system_enu_t = enumeration(oms_system_none,oms_system_tlm, oms_system_wc,oms_system_sc);

public function oms_addBus "Adds a bus"
  input String cref;
  output Integer status;
  external "C" status=OMSimulator_addBus(cref) annotation(Library = "omcruntime");;
end oms_addBus;

public function oms_addConnection "adds a connection between FMUS"
  input String crefA;
  input String crefB;
  output Integer status;
  external "C" status=OMSimulator_addConnection(crefA,crefB) annotation(Library = "omcruntime");;
end oms_addConnection;

function oms_addConnector
  input String cref;
  input Integer causality "oms_causality_input, oms_causality_output etc...";
  input Integer signaltype "oms_signal_type_real,oms_signal_type_integer,oms_signal_type_boolean ...";
  output Integer status;
  external "C" status=OMSimulator_addConnector(cref,causality,signaltype) annotation(Library = "omcruntime");;
end oms_addConnector;

function oms_addConnectorToBus
  input String busCref;
  input String connectorCref;
  output Integer status;
  external "C" status=OMSimulator_oms_addConnectorToBus(busCref,connectorCref) annotation(Library = "omcruntime");;
annotation(preferredView="text");
end oms_addConnectorToBus;

function oms_addConnectorToTLMBus
  input String busCref;
  input String connectorCref;
  input String type_;
  output Integer status;
  external "C" status=OMSimulator_oms_addConnectorToTLMBus(busCref,connectorCref,type_) annotation(Library = "omcruntime");;
end oms_addConnectorToTLMBus;

public function oms_addSubModel "creates a new subsystem to model"
  input String cref;
  input String fmupath;
  output Integer status;
  external "C" status=OMSimulator_addSubModel(cref,fmupath) annotation(Library = "omcruntime");;
end oms_addSubModel;

public function oms_addSystem "creates a new subsystem"
  input String cref;
  input Integer systype "oms_system_none,oms_system_tlm, oms_system_wc,oms_system_sc" ;
  output Integer status;
  external "C" status=OMSimulator_addSystem(cref,systype) annotation(Library = "omcruntime");;
end oms_addSystem;


public function oms_getVersion "Returns the version number of this release"
  output String outString;
  //external "C" outString=oms_getVersion() annotation(Library = "omcruntime");;
  external "C" outString = OMSimulator_oms_getVersion() annotation(Library = "omcruntime");;
end oms_getVersion;

public function oms_setLogFile "set the LogFile name defined by user"
  input String filename;
  output Integer status;
  external "C" status=OMSimulator_setLogFile(filename) annotation(Library = "omcruntime");;
end oms_setLogFile;

// TODO List of other OMSimulator API

public function oms_newModel "creates a new model"
  input String cref;
  output Integer status;
  external "C" status=OMSimulator_newModel(cref) annotation(Library = "omcruntime");;
end oms_newModel;

public function oms_setTempDirectory "creates a new model"
  input String newTempDir;
  output Integer status;
  external "C" status=OMSimulator_setTempDirectory(newTempDir) annotation(Library = "omcruntime");;
end oms_setTempDirectory;


public function oms_setResultFile "sets result file defined by user"
  input String cref;
  input String filename;
  input Integer buffersize;
  output Integer status;
  external "C" status=OMSimulator_setResultFile(cref,filename,buffersize) annotation(Library = "omcruntime");;
end oms_setResultFile;

public function oms_setStartTime "sets the startTime "
  input String cref;
  input Real startTime;
  output Integer status;
  external "C" status=OMSimulator_setStartTime(cref,startTime) annotation(Library = "omcruntime");;
end oms_setStartTime;

public function oms_setStopTime "sets the stopTime"
  input String cref;
  input Real stopTime;
  output Integer status;
  external "C" status=OMSimulator_setStopTime(cref,stopTime) annotation(Library = "omcruntime");;
end oms_setStopTime;

public function oms_setReal "sets the stopTime"
  input String cref;
  input Real value;
  output Integer status;
  external "C" status=OMSimulator_setReal(cref,value) annotation(Library = "omcruntime");;
end oms_setReal;

public function oms_setRealInputDerivative "sets the real input derivatives"
  input String cref;
  input Real value;
  output Integer status;
  external "C" status=OMSimulator_setRealInputDerivative(cref,value) annotation(Library = "omcruntime");;
end oms_setRealInputDerivative;

public function oms_setFixedStepSize "sets the real input derivatives"
  input String cref;
  input Real stepSize;
  output Integer status;
  external "C" status=OMSimulator_setFixedStepSize(cref,stepSize) annotation(Library = "omcruntime");;
end oms_setFixedStepSize;

function oms_instantiate "instantiate the fmus"
  input String cref;
  output Integer status;
  external "C" status=OMSimulator_instantiate(cref) annotation(Library = "omcruntime");;
end oms_instantiate;

function oms_initialize "initialize the fmus"
  input String cref;
  output Integer status;
  external "C" status=OMSimulator_initialize(cref) annotation(Library = "omcruntime");;
end oms_initialize;

function oms_simulate "simulate the fmus"
  input String cref;
  output Integer status;
  external "C" status=OMSimulator_simulate(cref) annotation(Library = "omcruntime");;
end oms_simulate;

function oms_getReal "get value of variable"
  input String cref;
  output Integer status;
  output Real value;
  external "C" status=OMSimulator_getReal(cref,value) annotation(Library = "omcruntime");;
end oms_getReal;

function oms_delete "deletes the model"
  input String cref;
  output Integer status;
  external "C" status=OMSimulator_delete(cref) annotation(Library = "omcruntime");;
end oms_delete;

function oms_terminate "terminates the model"
  input String cref;
  output Integer status;
  external "C" status=OMSimulator_terminate(cref) annotation(Library = "omcruntime");;
end oms_terminate;

function oms_setCommandLineOption "sets the command line options"
  input String cmd;
  output Integer status;
  external "C" status=OMSimulator_setCommandLineOption(cmd) annotation(Library = "omcruntime");;
end oms_setCommandLineOption;
*/
annotation(__OpenModelica_Interface="util");
end OMSimulator;
