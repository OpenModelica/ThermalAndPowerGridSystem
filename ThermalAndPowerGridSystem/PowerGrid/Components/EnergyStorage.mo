within ThermalAndPowerGridSystem.PowerGrid.Components;

model EnergyStorage "This model represents a Battery Storage system"
  
  extends Icons.EnergyStorage_Icon;
  
  import SI = Modelica.Units.SI;
  import nSI = Modelica.Units.NonSI;
  
  SI.Power powerInNout "Power supplied and taken from Storage";
  nSI.Energy_Wh storageEnergy "Energy Stored in Storage";
  Real energyPercentage " Percentage Energy of the storage";
  nSI.Energy_Wh allowableMaxCapacity "Allowable Max Capacity of storage (Whr)";
  nSI.Energy_Wh allowableMinCapacity "Allowable Min Capacity of storage (Whr)";
  
  parameter nSI.Energy_Wh storageCapacity = 5e6 " Storage Maximum capacity (Whr)";
  parameter Real maxEnergyPercentage = 95 "Maximum Percentage Energy Limt (%)";
  parameter Real minEnergyPercentage = 5 "Minimum Percentage Energy Limt (%)";
  
  ThermalAndPowerGridSystem.PowerGrid.Interfaces.ElectricalPort electricalPort annotation(
    Placement(visible = true, transformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput canCharge(start = true) annotation(
    Placement(visible = true, transformation(origin = {50, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {80, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.BooleanOutput canDischarge(start = false) annotation(
    Placement(visible = true, transformation(origin = {28, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {40, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput StorageEnergyOut annotation(
    Placement(visible = true, transformation(origin = {-28, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {-40, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput storageCapacityOut annotation(
    Placement(visible = true, transformation(origin = {-48, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {-80, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));

algorithm
  
   when storageEnergy <= allowableMinCapacity then
    canDischarge:=false;
   end when;
   when storageEnergy > allowableMinCapacity then
    canDischarge:=true; 
   end when;
   
  when storageEnergy >= allowableMaxCapacity then
    canCharge := false;  
  end when;
  when storageEnergy < allowableMaxCapacity then  
    canCharge := true;  
  end when;

equation

  allowableMaxCapacity = storageCapacity * maxEnergyPercentage / 100;
  allowableMinCapacity = storageCapacity * minEnergyPercentage / 100;
  electricalPort.P = -powerInNout;  
  der(storageEnergy) = powerInNout / 3600;  
  energyPercentage = storageEnergy / storageCapacity;  
  StorageEnergyOut = storageEnergy;  
  storageCapacityOut = storageCapacity;
  
annotation(
    Icon(graphics = {Text(origin = {0, -120}, extent = {{-100, 10}, {100, -10}}, textString = "%name", fontSize = 10)}),
    Documentation(info = "<html><head></head><body><!--StartFragment--><span style=\"font-size: 12px; font-family: 'DejaVu Sans Mono';\">This component will store the electrical energy as battery. Charging and discharging logic has been implemented in this component.</span><div><font face=\"DejaVu Sans Mono\"><br></font></div><div><font face=\"DejaVu Sans Mono\">Power value in positive(+ve) is considered as charging while power value in negative(-ve) is considered as discharging.<br></font><div><span style=\"font-family: 'DejaVu Sans Mono'; font-size: 12px;\"><br></span></div></div><!--EndFragment--></body></html>"));
end EnergyStorage;
