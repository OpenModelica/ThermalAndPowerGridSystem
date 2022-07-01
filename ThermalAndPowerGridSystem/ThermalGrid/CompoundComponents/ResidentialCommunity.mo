within ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents;

model ResidentialCommunity"Energy consumption for a residential community"
  extends Icons.ResidentialComplex;
  extends BaseComponents.ResidentialSpaceHeating;
  parameter Real peopleData = 1000;
 
 equation
  userDemand = EnergyPerHour * peopleData;
 if inFlow.massFlowRate <= 1e-6 then
    actualStream(outFlow.specificEnthalpy) * outFlow.massFlowRate + inFlow.massFlowRate * actualStream(inFlow.specificEnthalpy) = 0;
  else
    actualStream(outFlow.specificEnthalpy) * outFlow.massFlowRate + inFlow.massFlowRate * actualStream(inFlow.specificEnthalpy) = userDemand;
  end if;
 
annotation(
    Documentation(info = "<html><head></head><body>Yearly average user demand data is provided as input in this model.<div><br><div><br></div></div></body></html>"));
end ResidentialCommunity;
