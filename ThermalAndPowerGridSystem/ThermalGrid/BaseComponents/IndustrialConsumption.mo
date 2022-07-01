within ThermalAndPowerGridSystem.ThermalGrid.BaseComponents;

model IndustrialConsumption "Energy consumption model for industries, return temperature is modeled"
extends SystemSetup.SystemFluid;
   outer SystemSetup.AmbientConditions ambientConditions;
 
   import Modelica.Units.SI.Power;
   import Modelica.Units.SI.AbsolutePressure; 
   import Modelica.Units.SI.SpecificHeatCapacity;
   import AbsoluteTemperature = Modelica.Units.SI.Temperature;
 
  AbsoluteTemperature returnTemperature;
  AbsoluteTemperature supplyTemperature;
  AbsoluteTemperature TAmb = ambientConditions.Tambient;
 
  parameter AbsolutePressure delP = 2e5; 
  parameter Real energyPerIndustry= 125520;

 ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort outFlow annotation(
    Placement(visible = true, transformation(origin = {90, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort inFlow annotation(
    Placement(visible = true, transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

   Power industrialDemand; 
   
  equation
    industrialDemand = energyPerIndustry; 
    inFlow.pressure - delP = outFlow.pressure; 
    inFlow.specificEnthalpy = inStream(outFlow.specificEnthalpy);
    inFlow.massFlowRate + outFlow.massFlowRate = 0;  
    returnTemperature = FluidWater.temperature_phX(outFlow.pressure,outFlow.specificEnthalpy,{1});
    supplyTemperature = FluidWater.temperature_phX(inFlow.pressure,actualStream(inFlow.specificEnthalpy),{1});
       
end IndustrialConsumption;
