within ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents;

model SpaceHeating"Energy consumption for space heating for residential and commercial buildings of a country"
  extends Icons.ResidentialComplex;
  extends BaseComponents.ResidentialSpaceHeating;
  import Modelica.Units.SI.Power;
 
 Modelica.Blocks.Interfaces.RealInput heatDemand "Measured Space Heating Demand of a country in MW"annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, -68}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

 
equation
 userDemand = heatDemand*1e6;
 
 if inFlow.massFlowRate <= 1e-6 then
    actualStream(outFlow.specificEnthalpy) * outFlow.massFlowRate + inFlow.massFlowRate * actualStream(inFlow.specificEnthalpy) = 0;
 else
    actualStream(outFlow.specificEnthalpy) * outFlow.massFlowRate + inFlow.massFlowRate * actualStream(inFlow.specificEnthalpy) = userDemand;
 end if;
 
annotation(
    Documentation(info = "<html><head></head><body>Hourly data is extracted from UserDemandData under Utilities. Add required text file as data source.</body></html>"));
end SpaceHeating;
