within ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents.Storage;

model cylindricalTESnode "Stratified Tank Model...Geometry: Cylinder"
  //extends Icons.StratifiedTank;
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
  parameter Radius radiusTank = 25.25;
  parameter PerUnit Uside = 0.3 "Heat transfer coefficient";
  /*parameter*/
  Area areaNode = radiusTank * radiusTank * pi "Cross-sectional area of a segment";
  parameter Height heightNode = 5 " Height of each segment";
  //parameter Height heightTank = 50;
  Integer mode "1 - charging, 2 - storage/idle, 3 - discharging";
  /*(start=1, fixed=true)*/
  PerUnit pi = Modelica.Constants.pi;
  Density density "Density of medium";
  SpecificHeatCapacity cp "Specific Heat Capacity of medium";
  ThermalConductivity thermalConductivity "Thermal Conductivity of medium";
  Height perimeterNode "Surface area of a segment";
  Energy QlossNode;
  AbsoluteTemperature Tnode, inletTemperature;
  /*= 95 + 273*/
  /* Tground = 298,*/
  VolumeFlowRate Vw "Volume Flowrate of medium";
  /* =1000*/
  //Area areaTop, areaBottom " Cross-sectional area of first and last segment respectively";
  Real hour;
  /*, days*/
  //Real[12] cumDays = {31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365};
  //  Real mfr;
  //Tground[node];
  //  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort inFlow annotation(
  //    Placement(visible = true, transformation(origin = {-76, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort outFlow annotation(
  //    Placement(visible = true, transformation(origin = {-78, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-108, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  //Boolean charging "=1 if charging =0 if discharging";
  //  Interfaces.WaterPort coldIn annotation(
  //    Placement(visible = true, transformation(origin = {108, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {108, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort hotOut annotation(
  //    Placement(visible = true, transformation(origin = {108, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.tempConnector hotIn annotation(
    Placement(visible = true, transformation(origin = {-80, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.tempConnector hotOut annotation(
    Placement(visible = true, transformation(origin = {80, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.tempConnector coldOut annotation(
    Placement(visible = true, transformation(origin = {-80, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-80, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.tempConnector coldIn annotation(
    Placement(visible = true, transformation(origin = {80, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
initial equation
//  for a in 1:node loop
////    if a == 1 then
////      Tnode[a, 1] = 368.0;
////    elseif a == node then
////      Tnode[a, 1] = 343;
////    else
//// Tnode[a, 1] - (273 + 90) = -30 / heightTank * points[a];
//  //  Tnode[a, 1] - inletTemperature = (343 - inletTemperature) / heightTank * points[a];
  Tnode = 333;
//Tnode = 368;
////    end if;
//  end for;
equation
  density = 1000;
  cp = 4200;
  thermalConductivity = 0.6;
if mode ==1 then  
      inletTemperature = hotIn.temp;
      hotOut.temp = -Tambient;
      coldOut.temp= -Tnode;
      density * areaNode * cp * der(Tnode) = density * Vw * cp * (inletTemperature - Tnode) - QlossNode;
elseif mode ==2 then 
      inletTemperature = coldIn.temp;
      coldOut.temp = -Tambient;
      hotOut.temp= -Tnode;  
      density * areaNode * cp * der(Tnode) = density * Vw * cp * (inletTemperature - Tnode) - QlossNode;      
else
      inletTemperature = Tambient;
      coldOut.temp = -Tambient;
      hotOut.temp= -Tnode;  
density * areaNode * cp * der(Tnode) = /*density * Vw * cp * (inletTemperature-Tnode)*/ - QlossNode;          
end if;
//if mode ==1 then
//      inletTemperature = hotIn.temp;
//      hotOut.temp = -Tambient;
//      coldOut.temp= -Tnode;
//      Vw=13;
//elseif mode==3 then
//      inletTemperature = coldIn.temp;
//      coldOut.temp = -Tambient;
//      hotOut.temp= -Tnode;
//      Vw=13;
//else
//     Vw=0;
//    hotOut.temp=0;
//    coldOut.temp=0;
//     inletTemperature = 0;
//end if;
//when hour>1-1e-8 then
//    mode = 2;
//end when;
//areaTop = areaOfNode[1];
//dimensional parameters
// areaBottom = areaOfNode[node];
//  heightNode /*fill(heightTank / node, node);*/
//  areaOfNode = fill(2 * pi * radiusTank ^ 2, node);
  hour = mod(div(time, 3600), 24);
// days = div(time, 3600 * 24);
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
//  if days < cumDays[3] - 1e-8 then
//    mode = 1;
//  elseif days < cumDays[6] - 1e-8 then
//    mode = 2;
//  elseif days < cumDays[9] - 1e-8 then
//    mode = 3;
//  else
//    mode = 1;
//  end if;
//hotIn.massFlowRate + coldOut.massFlowRate =0;
//coldIn.massFlowRate + hotOut.massFlowRate = 0;
//hotIn.pressure=PAtm;
//hotOut.pressure = PAtm;
//coldIn.pressure = PAtm+density*Modelica.Constants.g_n*heightTank;
//coldOut.pressure=coldIn.pressure;
//hotOut.specificEnthalpy = inStream(hotIn.specificEnthalpy);
//coldOut.specificEnthalpy = inStream(coldIn.specificEnthalpy);
//hotIn.specificEnthalpy = inStream(hotIn.specificEnthalpy);
//coldIn.specificEnthalpy = inStream(coldIn.specificEnthalpy);
//enthalpy balance to be done.
//    inletTemperature = FluidWater.temperature_phX(hotIn.pressure, hotIn.specificEnthalpy, {1});
//    inStream(hotIn.specificEnthalpy) = hotOut.specificEnthalpy;
//coldIn.specificEnthalpy=0;
//  coldOut.specificEnthalpy=0;
//elseif mode ==2 then
//    inletTemperature = Tambient;
//    inStream(hotIn.specificEnthalpy) = hotOut.specificEnthalpy;
//   // coldIn.specificEnthalpy=0;
//    coldOut.specificEnthalpy=0;
//else
//    inletTemperature =  FluidWater.temperature_phX(coldIn.pressure, coldIn.specificEnthalpy, {1});
//    inStream(hotIn.specificEnthalpy) = hotOut.specificEnthalpy;
//   // coldIn.specificEnthalpy=0;
//    coldOut.specificEnthalpy=0;
//end if;
//  for i in 1:node loop
  perimeterNode = radiusTank * 2 * pi * heightNode;
//    if i == 1 then
//      Qloss[i] = areaTop * 0.1 * (Tnode[i, 1] - Tground) + Uside * perimeter[i] * (Tnode[i, 1] - Tground);
///*Uside*/
//    elseif i == node then
//      Qloss[i] = areaBottom * Uside * (Tnode[i, 1] - Tground) + Uside * perimeter[i] * (Tnode[i, 1] - Tground);
//    else
  QlossNode = Uside * perimeterNode * (Tnode - Tground);
//    end if;
//  end for;
//for i in 1:node loop
//    if mode == 1 then
//if hour>2 then
//Vw=-13;
//end if;
//if hour<2 and hour>1 then
//Vw = 0;
//else
  Vw = 13;
//end if;
//if hour >2 then
// density * areaNode * cp * der(Tnode) = -density * Vw * cp * (inletTemperature - Tnode) - QlossNode;
//else
  // end if;
/*density * Vw */
//   elseif mode == 3 then
//          density * areaOfNode[i] * cp * der(Tnode[i, 1]) = /*density * Vw */ coldIn.massFlowRate* cp * (SingleDer[i, :] * Tnode[:, 1]) + areaOfNode[i] * thermalConductivity * (DoubleDer[i, :] * Tnode[:, 1]) - Qloss[i];
//   else
//         density * areaOfNode[i] * cp * der(Tnode[i, 1]) = /*density * Vw */ /*hotIn.massFlowRate* cp * (SingleDer[i, :] * Tnode[:, 1]) +*/ areaOfNode[i] * thermalConductivity * (DoubleDer[i, :] * Tnode[:, 1]) - Qloss[i];
//   end if;
//end for;
  annotation(
    experiment(StartTime = 0, StopTime = 3.1536e+07, Tolerance = 1e-06, Interval = 63072),
    Diagram(graphics = {Rectangle(origin = {0.454201, 7.43058}, lineThickness = 1.25, extent = {{-99.5142, 50.4494}, {99.5142, -50.4494}}), Rectangle(origin = {0.25, 7.47}, fillColor = {255, 117, 25}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-95.67, 47.02}, {95.67, -47.02}})}),
    Icon(graphics = {Rectangle(origin = {0.454201, 7.43058}, lineThickness = 1.25, extent = {{-99.5142, 50.4494}, {99.5142, -50.4494}}), Rectangle(origin = {0.25, 7.47}, fillColor = {255, 117, 25}, fillPattern = FillPattern.Solid, lineThickness = 0.5, extent = {{-95.67, 47.02}, {95.67, -47.02}})}));
end cylindricalTESnode;
