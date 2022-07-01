within ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents;

model industrialComplex "Energy Consumption model for an industrial complex"
  extends Icons.IndustrialComplex;
  extends BaseComponents.IndustrialConsumption;
  
  import Modelica.Units.SI.Power;
  
  parameter Real industryNumber=10000;
  Power industrialDemand;
equation
 industrialDemand = energyPerIndustry * industryNumber;
if inFlow.massFlowRate<=1e-6 then
     actualStream(outFlow.specificEnthalpy)*outFlow.massFlowRate + inFlow.massFlowRate*actualStream(inFlow.specificEnthalpy) =0; 
else
      actualStream(outFlow.specificEnthalpy)*outFlow.massFlowRate + inFlow.massFlowRate*actualStream(inFlow.specificEnthalpy) = industrialDemand; 
end if;
end industrialComplex;
