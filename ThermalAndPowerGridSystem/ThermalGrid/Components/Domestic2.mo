within ThermalAndPowerGridSystem.ThermalGrid.Components;

model Domestic2 "Domestic Space Heating Consumption, return temperature is modeled, for one house."
 extends Icons.spaceHeating;
 extends BaseComponents.ResidentialSpaceHeating;

 equation
  userDemand = EnergyPerHour;
   if inFlow.massFlowRate<=1e-6 then
     actualStream(outFlow.specificEnthalpy)*outFlow.massFlowRate + inFlow.massFlowRate*actualStream(inFlow.specificEnthalpy) =0; 
else
      actualStream(outFlow.specificEnthalpy)*outFlow.massFlowRate + inFlow.massFlowRate*actualStream(inFlow.specificEnthalpy) = userDemand; 
end if;  

end Domestic2;
