within ThermalAndPowerGridSystem.ThermalGrid.Control;

model HeatManagementSystem
  extends ThermalAndPowerGridSystem.ThermalGrid.Icons.Control2;
  outer SystemSetup.AmbientConditions ambientConditions;
  import AbsoluteTemperature = Modelica.Units.SI.Temperature;
  
  Modelica.Blocks.Interfaces.RealInput tSupply annotation(
    Placement(visible = true, transformation(origin = {-86, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-111, 19}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
  AbsoluteTemperature temperatureSupply;
 
 parameter AbsoluteTemperature districtHeatingTemperature = 273+95;
 Modelica.Blocks.Interfaces.BooleanOutput hotWaterSupplyswitch annotation(
    Placement(visible = true, transformation(origin = {-28, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {-34, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
 Modelica.Blocks.Interfaces.BooleanOutput coldWaterBypassSwitch annotation(
    Placement(visible = true, transformation(origin = {-76, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {-110, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
 Modelica.Blocks.Interfaces.BooleanOutput outletValveTESswitch annotation(
    Placement(visible = true, transformation(origin = {-26, -74}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-2, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
 Modelica.Blocks.Interfaces.BooleanOutput inletValveTEShotswitch annotation(
    Placement(visible = true, transformation(origin = {68, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

 Boolean temperatureBand, belowTemperatureBand, aboveTemperatureBand;
  Modelica.Blocks.Interfaces.BooleanOutput outletPumpSolarswitch annotation(
    Placement(visible = true, transformation(origin = {68, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0))); equation
temperatureSupply = tSupply;

algorithm

if temperatureSupply>=(districtHeatingTemperature-5) and temperatureSupply<= (districtHeatingTemperature+5) then 
     temperatureBand:= false;
     belowTemperatureBand := false;
     aboveTemperatureBand := true;
elseif temperatureSupply<  (districtHeatingTemperature-5) then
     belowTemperatureBand :=true;
     temperatureBand := false;
     aboveTemperatureBand := false;
 else
    aboveTemperatureBand := true;
    temperatureBand := false;
    belowTemperatureBand := false;
end if;           
 
 if temperatureBand then 
     outletPumpSolarswitch :=true;
     hotWaterSupplyswitch := true;
     coldWaterBypassSwitch := false; 
     inletValveTEShotswitch := false;
     outletValveTESswitch := false;
 elseif aboveTemperatureBand then 
     hotWaterSupplyswitch := false;
     outletPumpSolarswitch := false;
     coldWaterBypassSwitch := true; 
     inletValveTEShotswitch := true;
     outletValveTESswitch := false;
 elseif belowTemperatureBand then
     outletPumpSolarswitch :=true;
     hotWaterSupplyswitch := true;
     outletValveTESswitch := true;
     coldWaterBypassSwitch := false; 
     inletValveTEShotswitch := false;
 end if; 


end HeatManagementSystem;
