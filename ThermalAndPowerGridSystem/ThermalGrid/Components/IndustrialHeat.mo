within ThermalAndPowerGridSystem.ThermalGrid.Components;

model IndustrialHeat "Energy consumption model for industries, return temperature is modeled for one industry"
extends Icons.Industry;
extends BaseComponents.IndustrialConsumption;

equation
 industrialDemand = energyPerIndustry; /**industryNumber;*/
if inFlow.massFlowRate<=1e-6 then
     actualStream(outFlow.specificEnthalpy)*outFlow.massFlowRate + inFlow.massFlowRate*actualStream(inFlow.specificEnthalpy) =0; 
else
      actualStream(outFlow.specificEnthalpy)*outFlow.massFlowRate + inFlow.massFlowRate*actualStream(inFlow.specificEnthalpy) = industrialDemand; 
end if;
end IndustrialHeat;
