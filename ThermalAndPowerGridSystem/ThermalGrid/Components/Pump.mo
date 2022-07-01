within ThermalAndPowerGridSystem.ThermalGrid.Components;

model Pump "Model to find the power consumed by the pump and pressure drop"
extends Icons.Pump; 
extends SystemSetup.SystemFluid;
 outer SystemSetup.AmbientConditions ambientConditions;
  SystemSetup.Constants constants;
  import Modelica.Units.SI.Efficiency;
  import Pressure = Modelica.Units.SI.AbsolutePressure;
  import Modelica.Units.SI.MassFlowRate;
  import Modelica.Units.SI.SpecificEnthalpy;
  import Modelica.Units.SI.Power;
  import Modelica.Units.SI.Height;
  import DelP = Modelica.Units.SI.PressureDifference;
  import Modelica.Units.SI.Density;

  parameter Efficiency pumpEff(min = 0, max = 1) = 0.8 " Efficiency of pump";
  parameter MassFlowRate massFlowRate = 1e3;
  DelP delP;
  Power pumpPower "Power consumed by pump";
  Height pumpHead "Head due to pump";
  Density liquidDensity;
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort inFlow "input connector" annotation(
    Placement(visible = true, transformation(origin = {-94, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-96, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort outFlow "output connector" annotation(
    Placement(visible = true, transformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Modelica.Blocks.Interfaces.BooleanInput pumpControl annotation(
    Placement(visible = true, transformation(origin = {108, 0}, extent = {{20, -20}, {-20, 20}}, rotation = 0), iconTransformation(origin = {2, 94}, extent = {{12, -12}, {-12, 12}}, rotation = 90)));

equation
if cardinality(pumpControl) ==0 then
   pumpControl = true;
 end if;
 
 if (pumpControl) then 
  massFlowRate = inFlow.massFlowRate;
 else 
  inFlow.massFlowRate = 1e-6; 
 end if;  
 
  outFlow.specificEnthalpy = inStream(inFlow.specificEnthalpy);
  inFlow.specificEnthalpy = inStream(outFlow.specificEnthalpy);
  liquidDensity = FluidWater.density_phX(inFlow.pressure, inFlow.specificEnthalpy,{1});
  inFlow.massFlowRate + outFlow.massFlowRate = 0;
  delP = pumpHead * liquidDensity * constants.g;
  inFlow.pressure + delP = outFlow.pressure;
  pumpPower = inFlow.massFlowRate * pumpHead * constants.g / pumpEff; //Power consumption of Pump
end Pump;
