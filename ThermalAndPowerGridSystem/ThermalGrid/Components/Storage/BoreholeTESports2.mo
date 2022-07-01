within ThermalAndPowerGridSystem.ThermalGrid.Components.Storage;

model BoreholeTESports2 "Stratified Tank Model...Geometry: Cylinder"
  extends Icons.StratifiedTank;
  extends ThermalAndPowerGridSystem.ThermalGrid.SystemSetup.SystemFluid;
  extends ThermalAndPowerGridSystem.ThermalGrid.SystemSetup.AmbientConditions;
  
  import Modelica.Units.SI.PerUnit;
  import Modelica.Units.SI.Density;
  import Modelica.Units.SI.SpecificHeatCapacity;
  import Modelica.Units.SI.ThermalConductivity;
  import Modelica.Units.SI.VolumeFlowRate;
  import Modelica.Units.SI.Area;
  import Modelica.Units.SI.Energy;
  import AbsoluteTemperature = Modelica.Units.SI.Temperature;
  import Modelica.Units.SI.Height;
  import Modelica.Units.SI.Radius;
  import Modelica.Units.SI.Length;
  import Modelica.Units.SI.Angle;
  parameter Real SingleDer[node, node] = ThermalAndPowerGridSystem.ThermalGrid.Functions.FDFESingleDer(N = node, z = points, L = heightTank);
  parameter Real DoubleDer[node, node] = ThermalAndPowerGridSystem.ThermalGrid.Functions.FDFEDoubleDer(N = node, z = points, L = heightTank);
  parameter Real points[node] = linspace(0, heightTank, node);
  parameter Integer node = 10 "Number of nodes that the TES is assumed to be divided into";
  parameter Radius radiusTank = 25.25;
  /*50*/
  parameter Height heightTank = 50;
  /*1000*/
  Integer mode(start=1) "1 - charging, 2 - storage/idle, 3 - discharging";
  PerUnit pi = Modelica.Constants.pi;
  Density density "Density of medium";
  SpecificHeatCapacity cp "Specific Heat Capacity of medium";
  ThermalConductivity thermalConductivity "Thermal Conductivity of medium";
  /*parameter*/
  //VolumeFlowRate Vw "Volume Flowrate of medium";
  /* =1000*/
  Area areaOfNode[node] "Cross-sectional area of a segment";
  Area areaTop, areaBottom " Cross-sectional area of first and last segment respectively";
  Height perimeter[node] "Perimeter of a segment";
  Height heightNode[node] " Height of each segment";
  Energy Qloss[node];
  AbsoluteTemperature Tnode[node, 1], Tvariation[node]/*, Tground = 298*/, inletTemperature;
  Real hour, days;
  Real[12] cumDays = {31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365};
 // Real mfr;
  //Tground[node];
  parameter PerUnit Uside = 0.3 "Heat transfer coefficient";
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort hotIn annotation(
    Placement(visible = true, transformation(origin = {-76, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort coldOut annotation(
    Placement(visible = true, transformation(origin = {-78, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-108, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //Boolean charging "=1 if charging =0 if discharging";
  Interfaces.WaterPort coldIn annotation(
    Placement(visible = true, transformation(origin = {108, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {108, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort hotOut annotation(
    Placement(visible = true, transformation(origin = {108, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
initial equation
  for a in 1:node loop
//    if a == 1 then
//      Tnode[a, 1] = 368.0;
//    elseif a == node then
//      Tnode[a, 1] = 343;
//    else
// Tnode[a, 1] - (273 + 90) = -30 / heightTank * points[a];
  //  Tnode[a, 1] - inletTemperature = (343 - inletTemperature) / heightTank * points[a];
  Tnode[a,1] = 333;
//    end if;
  end for;
equation
  density = 1000;
//properties
  cp = 4200;
  thermalConductivity = 0.6;
  areaTop = areaOfNode[1];
//dimensional parameters
  areaBottom = areaOfNode[node];
  heightNode = fill(heightTank / node, node);
  areaOfNode = fill(2 * pi * radiusTank ^ 2, node);
  hour = mod(div(time, 3600), 24);
  days = div(time, 3600 * 24);
//   if days < cumDays[3] - 1e-8 then
//     Vw = 0.5;
//  elseif days<cumDays[6] - 1e-8 then
//     Vw = 0;
//  elseif days<cumDays[9] - 1e-8 then
//    Vw = -0.5;
//  else
//    Vw = 0;
//  end if;
//  if days < cumDays[3] - 1e-8 then
//      inlet.massFlowRate/density = Vw;
//elseif  days<cumDays[6] - 1e-8 then
//     Vw = 0;
//elseif days<cumDays[9] - 1e-8 then
//   Vw = outlet.massFlowRate/density;
//  else
//    Vw = 0;
//  end if;
//Vw = mfr/density;
//CHOOSING MODES:
  if days < cumDays[3] - 1e-8 then
    mode = 1;
  elseif days < cumDays[6] - 1e-8 then
    mode = 2;
  elseif days < cumDays[9] - 1e-8 then
    mode = 3;
  else
    mode = 1;
  end if;
  
hotIn.massFlowRate + coldOut.massFlowRate =0;
coldIn.massFlowRate + hotOut.massFlowRate = 0;
hotIn.pressure=PAtm;
hotOut.pressure = PAtm;
coldIn.pressure = PAtm+density*Modelica.Constants.g_n*heightTank;
coldOut.pressure=coldIn.pressure;
//hotOut.specificEnthalpy = inStream(hotIn.specificEnthalpy);
//coldOut.specificEnthalpy = inStream(coldIn.specificEnthalpy);
//hotIn.specificEnthalpy = inStream(hotIn.specificEnthalpy);
//coldIn.specificEnthalpy = inStream(coldIn.specificEnthalpy);
//enthalpy balance to be done.


if mode ==1 then
    inletTemperature = FluidWater.temperature_phX(hotIn.pressure, hotIn.specificEnthalpy, {1});
    inStream(hotIn.specificEnthalpy) = hotOut.specificEnthalpy;
    //coldIn.specificEnthalpy=0;
    coldOut.specificEnthalpy=0;
elseif mode ==2 then 
    inletTemperature = Tambient;
    inStream(hotIn.specificEnthalpy) = hotOut.specificEnthalpy;
   // coldIn.specificEnthalpy=0;
    coldOut.specificEnthalpy=0;
else    
    inletTemperature =  FluidWater.temperature_phX(coldIn.pressure, coldIn.specificEnthalpy, {1});
    inStream(hotIn.specificEnthalpy) = hotOut.specificEnthalpy;
   // coldIn.specificEnthalpy=0;
    coldOut.specificEnthalpy=0;
end if;
    
 
  for i in 1:node loop
    perimeter[i] = radiusTank * 2 * pi * heightNode[i];
    if i == 1 then
      Qloss[i] = areaTop * 0.1 * (Tnode[i, 1] - Tground) + Uside * perimeter[i] * (Tnode[i, 1] - Tground);
/*Uside*/
    elseif i == node then
      Qloss[i] = areaBottom * Uside * (Tnode[i, 1] - Tground) + Uside * perimeter[i] * (Tnode[i, 1] - Tground);
    else
      Qloss[i] = Uside * perimeter[i] * (Tnode[i, 1] - Tground);
    end if;
  end for;

for i in 1:node loop
    if mode == 1 then
           density * areaOfNode[i] * cp * der(Tnode[i, 1]) = /*density * Vw */ hotIn.massFlowRate* cp * (SingleDer[i, :] * Tnode[:, 1]) + areaOfNode[i] * thermalConductivity * (DoubleDer[i, :] * Tnode[:, 1]) - Qloss[i];
   elseif mode == 3 then
          density * areaOfNode[i] * cp * der(Tnode[i, 1]) = /*density * Vw */ coldIn.massFlowRate* cp * (SingleDer[i, :] * Tnode[:, 1]) + areaOfNode[i] * thermalConductivity * (DoubleDer[i, :] * Tnode[:, 1]) - Qloss[i];
   else
          density * areaOfNode[i] * cp * der(Tnode[i, 1]) = /*density * Vw */ /*hotIn.massFlowRate* cp * (SingleDer[i, :] * Tnode[:, 1]) +*/ areaOfNode[i] * thermalConductivity * (DoubleDer[i, :] * Tnode[:, 1]) - Qloss[i];
   end if;       
end for;

  Tvariation[:] = Tnode[:, 1];
  annotation(
    experiment(StartTime = 0, StopTime = 3.1536e+07, Tolerance = 1e-06, Interval = 63072));
end BoreholeTESports2;
