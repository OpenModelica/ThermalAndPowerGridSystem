within ThermalAndPowerGridSystem.ThermalGrid.Control;

model Scenario1Controller3 " Central Controller for Scenario 2"
  extends ThermalAndPowerGridSystem.ThermalGrid.Icons.Control2;
  import Modelica.Units.SI.PerUnit;
  import AbsoluteTemperature = Modelica.Units.SI.Temperature;
  
  parameter AbsoluteTemperature T_DH = 348.15 "District Heating Temperature SetPoint";
  parameter AbsoluteTemperature T_DH_L = 343.15 "DH Low Limit";
  parameter AbsoluteTemperature T_DH_LL = 338.15 "DH LowLow Limit";
  parameter AbsoluteTemperature T_DH_H = 353.15 "DH High Limit";
  
  AbsoluteTemperature T_SUP "Suppy Tank Temperature";
  Boolean modeSolar, modeTES, modeBoiler, modeHeatBypass;
  
  Real hour, days;
  Modelica.Blocks.Interfaces.RealInput supplyTemperature annotation(
    Placement(visible = true, transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {50, 110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.BooleanOutput coldWaterSupplyBoilerControl annotation(
   Placement(visible = true, transformation(origin = {-164, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Interfaces.BooleanOutput bypassValveControl annotation(
    Placement(visible = true, transformation(origin = {-150, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Interfaces.BooleanOutput solarOutletValveControl annotation(
    Placement(visible = true, transformation(origin = {106, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput outletPumpColdTankControl annotation(
    Placement(visible = true, transformation(origin = {106, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput outletPumpTEScontrol annotation(
    Placement(visible = true, transformation(origin = {-4, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {66, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.BooleanOutput outletPumpColdTank2Control annotation(
    Placement(visible = true, transformation(origin = {-50, -128}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-60, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
algorithm
  when initial() then
      modeBoiler :=false;
      modeSolar :=true;
      modeTES := false;
      modeHeatBypass := false;
  end when;

when T_SUP < T_DH_LL then
    modeSolar := false;
 end when;
 
//when T_SUP< T_DH_L then
//     modeTES := true;
//end when;

//when T_SUP >T_DH then 
//     modeTES:=false;
//end when;

when T_SUP > T_DH_L then
    modeSolar := true;
    modeBoiler := false;
end when;

when T_SUP < T_DH then
    modeHeatBypass := false;
end when;

when T_SUP > T_DH_H then
    modeHeatBypass:=true;
    modeBoiler := false;
    modeSolar := false;
end when;

when modeTES and T_SUP<T_DH_LL then
   modeBoiler :=true;
   modeTES := false;
end when;
                      
equation
  days = div(time, 3600 * 24);
  hour = mod(div(time, 3600), 24);
  T_SUP = supplyTemperature;


  if modeSolar then
    outletPumpColdTankControl = true;
    coldWaterSupplyBoilerControl = false;
    bypassValveControl = false;
    solarOutletValveControl = true;
    outletPumpTEScontrol = false;
  elseif modeTES then
    outletPumpColdTankControl = false;
    coldWaterSupplyBoilerControl = false;
    bypassValveControl = false;
    solarOutletValveControl = false;
    outletPumpTEScontrol = true;
  elseif modeBoiler then
    outletPumpColdTankControl = true;
    coldWaterSupplyBoilerControl = true;
    bypassValveControl = false;
    solarOutletValveControl = false;
    outletPumpTEScontrol = false;
  elseif modeHeatBypass then
    outletPumpColdTankControl = true;
    coldWaterSupplyBoilerControl = false;
    bypassValveControl = true;
    solarOutletValveControl = false;
    outletPumpTEScontrol = false;
  else
    outletPumpColdTankControl = true;
    coldWaterSupplyBoilerControl = false;
    bypassValveControl = false;
    solarOutletValveControl = true;
    outletPumpTEScontrol = false;
  end if;

  if hour > 6 - 1e8 and hour < 18 + 1e-8 and days > 90 and days < 240 then

    outletPumpColdTank2Control = true;
  else
    outletPumpColdTank2Control = false;
  end if;

end Scenario1Controller3;
