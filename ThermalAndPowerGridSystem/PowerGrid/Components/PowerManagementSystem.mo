within ThermalAndPowerGridSystem.PowerGrid.Components;

model PowerManagementSystem
  
  extends Icons.ManagementSystem_Icon;
  
  import SI = Modelica.Units.SI;
  
  SI.Power availableWindGeneratedPower;
  SI.Power availableSolarGeneratedPower; 
  SI.Power availableGeneratedPower "available generated power (W)";
  SI.Power availableDomesticDemandPower;
  SI.Power availableChargingStationDemandPower; 
  SI.Power totalDemandPower"Total Demand power (W)";
  SI.Power powerTransferedToStorage "Power transferred to/from Storage (W)";
  SI.Power powerTransferedToGrid "Power transferred to/from Grid (W)";
  
  Real totalGenerationCost;
  Real totalDemandCost;
  Real totalStorageCost;
  
  parameter Real solarGenCost = 10 "Cost for Power generated from solar (per unit cost)";
  parameter Real windGenCost = 10 "Cost for Power generated from wind (per unit cost)";
  parameter Real energyStorageCost = 10 "Cost for Storing energy (per unit cost)";  
  parameter Real dosmesticDemandCost = 10 "Cost for Power demand by consumers (per unit cost)";
  parameter Real chargingStationCost = 10 "Cost for Power utilisied by charging station (per unit cost)";
  parameter SI.Efficiency tndEfficiency = 0.9 " Transmission & Distribution Efficiency";
  parameter SI.Voltage V =11e3 " Grid Voltage (dummy variable)";
  parameter SI.Power storageSupplyPowerLimit = 0.5e6 "Charge & Discharge Power Limit of the energy storage (W)";

  ThermalAndPowerGridSystem.PowerGrid.Interfaces.ElectricalPort windGenerationPort annotation(
    Placement(visible = true, transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Interfaces.ElectricalPort solarGenerationPort annotation(
    Placement(visible = true, transformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Interfaces.ElectricalPort storagePort annotation(
    Placement(visible = true, transformation(origin = {-50, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Interfaces.ElectricalPort domesticDemandPort annotation(
    Placement(visible = true, transformation(origin = {90, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Interfaces.ElectricalPort chargingStationDemandPort annotation(
    Placement(visible = true, transformation(origin = {90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Interfaces.ElectricalPort sourceSinkPort annotation(
    Placement(visible = true, transformation(origin = {50, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput canCharge annotation(
    Placement(visible = true, transformation(origin = {-20, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {28, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.BooleanInput canDischarge annotation(
    Placement(visible = true, transformation(origin = {20, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {-30, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput powerTransferedToStorageOut annotation(
    Placement(visible = true, transformation(origin = {24, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {50, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput powerTransferedToGridOut annotation(
    Placement(visible = true, transformation(origin = {50, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {80, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput availableWindGeneratedPowerOut annotation(
    Placement(visible = true, transformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {20, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput availableSolarGeneratedPowerOut annotation(
    Placement(visible = true, transformation(origin = {-18, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {-20, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput availableDomesticDemandPowerOut annotation(
    Placement(visible = true, transformation(origin = {-32, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {-50, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput availableChargingStationDemandPowerOut annotation(
    Placement(visible = true, transformation(origin = {-48, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {-80, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));

algorithm
  
  totalGenerationCost := windGenerationPort.P * windGenCost + solarGenerationPort.P * solarGenCost;
  totalDemandCost := chargingStationDemandPort.P * chargingStationCost + domesticDemandPort.P * dosmesticDemandCost;
  totalStorageCost := storagePort.P * energyStorageCost;
   
  if availableGeneratedPower >= totalDemandPower then 
    
    if canCharge == false then
        powerTransferedToStorage := 0;
        powerTransferedToGrid := availableGeneratedPower - totalDemandPower - powerTransferedToStorage;
    elseif canCharge == true then
        if (availableGeneratedPower - totalDemandPower) <= storageSupplyPowerLimit then
          powerTransferedToStorage := availableGeneratedPower - totalDemandPower;
          powerTransferedToGrid := availableGeneratedPower - totalDemandPower - powerTransferedToStorage;
        elseif (availableGeneratedPower - totalDemandPower) > storageSupplyPowerLimit then
          powerTransferedToStorage := storageSupplyPowerLimit;
          powerTransferedToGrid := availableGeneratedPower - totalDemandPower - powerTransferedToStorage;
        end if;
    end if;
     
  elseif availableGeneratedPower < totalDemandPower then
       
    if canDischarge == true then
      if (totalDemandPower - availableGeneratedPower) < storageSupplyPowerLimit then
          powerTransferedToStorage := -(totalDemandPower - availableGeneratedPower);
          powerTransferedToGrid := -(totalDemandPower - availableGeneratedPower + powerTransferedToStorage);
      elseif (totalDemandPower - availableGeneratedPower) >= storageSupplyPowerLimit then
          powerTransferedToStorage := -storageSupplyPowerLimit;
          powerTransferedToGrid := -(totalDemandPower - availableGeneratedPower + powerTransferedToStorage);
      end if;
    elseif canDischarge == false then
      powerTransferedToStorage := 0;
      powerTransferedToGrid := availableGeneratedPower - totalDemandPower;
    end if;
 
  end if;

equation
  windGenerationPort.V = V;
  solarGenerationPort.V = V;
  storagePort.V = V;
  domesticDemandPort.V = V;
  chargingStationDemandPort.V = V;
  sourceSinkPort.V = V;
  availableWindGeneratedPower = tndEfficiency * windGenerationPort.P;
  availableSolarGeneratedPower = tndEfficiency * solarGenerationPort.P;
  availableGeneratedPower = availableWindGeneratedPower + availableSolarGeneratedPower;
  
  totalDemandPower = availableDomesticDemandPower + availableChargingStationDemandPower;
  availableDomesticDemandPower = domesticDemandPort.P / tndEfficiency;
  availableChargingStationDemandPower = chargingStationDemandPort.P / tndEfficiency;
      
  storagePort.P = powerTransferedToStorage;
  sourceSinkPort.P = powerTransferedToGrid; 
 
  powerTransferedToStorageOut = powerTransferedToStorage;
  powerTransferedToGridOut = powerTransferedToGrid;
  availableWindGeneratedPowerOut = availableWindGeneratedPower;
  availableSolarGeneratedPowerOut = availableSolarGeneratedPower;
  availableDomesticDemandPowerOut = availableDomesticDemandPower;
  availableChargingStationDemandPowerOut = availableChargingStationDemandPower;
  
annotation(
    Icon(graphics = {Text(origin = {0, -120}, rotation = 180, extent = {{-100, 20}, {100, 0}}, textString = "%name", fontSize = 12)}),
    Documentation(info = "<html><head></head><body><!--StartFragment--><div>Simple conditional logic is implemented in this model.</div><div>&nbsp;</div>This component will manage all the source power and sink power.<div>This components take care of when power should be tranferred to energy storage to charge keeping the constraint such as battery should not be over charged and energy level in battery should not be less than certain value.</div><div><br></div><div>This manages conventional grid by calculating when to take power from grid and when to transfer surplus generated power to grid, keeping the constrain domestic demand and charging station demand should be always meet.</div><!--EndFragment--></body></html>"));
end PowerManagementSystem;
