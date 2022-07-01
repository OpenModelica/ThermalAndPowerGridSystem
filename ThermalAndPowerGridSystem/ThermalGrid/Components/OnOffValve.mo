within ThermalAndPowerGridSystem.ThermalGrid.Components;

model OnOffValve"On-Off Valve, pressure drop model"

extends Icons.LinearValve;
  import AbsoluteTemperature = Modelica.Units.SI.Temperature;
  import AbsolutePressure = Modelica.Units.SI.AbsolutePressure;
  import DeltaP = Modelica.Units.SI.PressureDifference;
  import Modelica.Units.SI.MassFlowRate;
  import Modelica.Units.SI.SpecificEnthalpy;
  import Modelica.Units.SI.Density;
  
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort portA annotation(
    Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-82, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort portB annotation(
    Placement(visible = true, transformation(origin = {90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {86, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput valveSwitch annotation(
    Placement(visible = true, transformation(origin = {-1, -29}, extent = {{-29, -29}, {29, 29}}, rotation = 90), iconTransformation(origin = {0, 90}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));

  parameter Real Cv = 0.05;
  DeltaP deltaP;
 
equation
 if cardinality(valveSwitch) == 0 then
     valveSwitch = true;
 end if; 
 
 if  (valveSwitch) then
     portA.massFlowRate=Cv*deltaP;  
     deltaP = portA.pressure - portB.pressure;
   else   
      portA.massFlowRate=1e-6*deltaP; 
    deltaP = portA.pressure - portB.pressure;
  
 end if;
   
  portA.massFlowRate + portB.massFlowRate = 0;
  portA.specificEnthalpy = inStream(portB.specificEnthalpy);
  portB.specificEnthalpy = inStream(portA.specificEnthalpy);
end OnOffValve;
