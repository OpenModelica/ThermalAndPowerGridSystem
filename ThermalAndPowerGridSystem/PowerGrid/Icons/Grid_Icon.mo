within ThermalAndPowerGridSystem.PowerGrid.Icons;

model Grid_Icon
equation

annotation(
    Icon(graphics = {Rectangle(lineColor = {169, 211, 250}, fillColor = {169, 211, 250}, fillPattern = FillPattern.Sphere, extent = {{-100, 100}, {100, -100}}, radius = 10), Bitmap(origin = {0, -1}, extent = {{-94, -105}, {94, 105}}, imageSource = "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")}),
    Diagram);
end Grid_Icon;