within ThermalAndPowerGridSystem.ThermalGrid.BaseComponents;

model ResidentialSpaceHeating "Residential space heating consumption, retrun temperature are modeled"
extends SystemSetup.SystemFluid;
  outer  SystemSetup.AmbientConditions ambientConditions;
 
   import Modelica.Units.SI.Power;
   import Modelica.Units.SI.AbsolutePressure; 
   import Modelica.Units.SI.SpecificHeatCapacity;
   import AbsoluteTemperature = Modelica.Units.SI.Temperature;
 
  parameter Real EnergyUsePerPersonPerYear = 7000000 "Wh";
  parameter AbsolutePressure delP = 2e5; 

  Real hour;
  Power EnergyDemandPerDay, EnergyPerHour, PeakEnergyPerHour;
  AbsoluteTemperature returnTemperature;
  AbsoluteTemperature supplyTemperature;
  AbsoluteTemperature TAmb = ambientConditions.Tambient;
  Power userDemand;
 ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort outFlow annotation(
    Placement(visible = true, transformation(origin = {90, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort inFlow annotation(
    Placement(visible = true, transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 
    equation
 EnergyDemandPerDay = EnergyUsePerPersonPerYear / 365;
  hour = mod(div(time, 3600), 24);
  if hour < 9 -1e-8 then // and hour >= 21 then
    EnergyPerHour = 0.5 * (EnergyDemandPerDay / 24);
  elseif hour<21  -1e-8 then
    EnergyPerHour = 1.5 * (EnergyDemandPerDay / 24);
  else 
    EnergyPerHour = 0.5 * (EnergyDemandPerDay / 24);
  end if;
  PeakEnergyPerHour = 1.5 * (EnergyDemandPerDay/24);


 inFlow.pressure - delP = outFlow.pressure; 
 inFlow.specificEnthalpy = inStream(inFlow.specificEnthalpy);
 inFlow.massFlowRate + outFlow.massFlowRate = 0;  
 returnTemperature = FluidWater.temperature_phX(outFlow.pressure,outFlow.specificEnthalpy,{1});
 supplyTemperature = FluidWater.temperature_phX(inFlow.pressure,actualStream(inFlow.specificEnthalpy),{1});
 
    
      
end ResidentialSpaceHeating;
