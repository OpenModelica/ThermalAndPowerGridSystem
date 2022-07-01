within ThermalAndPowerGridSystem.ThermalGrid.Components;

model Boiler "Source Model - Heat Generation"
extends Icons.Boiler; 
extends SystemSetup.SystemFluid;
inner SystemSetup.AmbientConditions ambientConditions;

  import AbsoluteTemperature = Modelica.Units.SI.Temperature;
  import AbsolutePressure = Modelica.Units.SI.AbsolutePressure;
  import Modelica.Units.SI.Power;
  import Modelica.Units.SI.MassFlowRate;
  import Modelica.Units.SI.SpecificEnthalpy;
  import Modelica.Units.SI.SpecificEnergy;
  import Modelica.Units.SI.Efficiency;
 
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.ThermalPort heatOut annotation(
    Placement(visible = true, transformation(origin = {2, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput FuelFlowRate annotation(
    Placement(visible = true, transformation(origin = {-63, 21}, extent = {{-17, -17}, {17, 17}}, rotation = 0), iconTransformation(origin = {-107, 1}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  
  parameter SpecificEnergy calorificValue = 12.5e6 "Wood Chips - in J/kg";
  parameter Efficiency boilerEfficiency = 0.8;
  //parameter AbsoluteTemperature outputTemperature = 400;
  
  MassFlowRate fuelFlowRate;
  Modelica.Blocks.Interfaces.BooleanInput boilerSwitch annotation(
    Placement(visible = true, transformation(origin = {-57, -25}, extent = {{-19, -19}, {19, 19}}, rotation = 0), iconTransformation(origin = {-107, -47}, extent = {{-7, -7}, {7, 7}}, rotation = 0))); equation
 
  if cardinality(boilerSwitch) == 0 then
    boilerSwitch = true;
  end if;
  if boilerSwitch then
    FuelFlowRate = fuelFlowRate;
  else
    fuelFlowRate = 0;
  end if;
    
  heatOut.W = -boilerEfficiency * fuelFlowRate * calorificValue;
  heatOut.T =373; /*FluidWater.temperature_phX(ambientConditions.PAtm, -heatOut.W, {1});*/
end Boiler;
