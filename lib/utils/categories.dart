// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:major_project/utils/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

final categories = [
  'Carpenter',
  'Plumber',
  'Electrician',
  'Cleaning',
  'Appliances',
  'AC service',
  'Painting',
  'Refrigerators',
  'Washing\nMachines'
];

final Map CategoriesIcons = {
  'Carpenter': MdiIcons.handSaw,
  'Plumber': Icons.plumbing,
  'Electrician': MdiIcons.lightningBolt,
  'Cleaning': MdiIcons.vacuum,
  'Appliances': Icons.lightbulb,
  'AC service': MdiIcons.airConditioner,
  'Painting': Icons.imagesearch_roller_rounded,
  'Refrigerators': MdiIcons.fridge,
  'Washing\nMachines': Icons.local_laundry_service,
};

final Map categoryOffers = {
  'Carpenter': [
    'Furniture Repair',
    'Furniture Assembly',
    'Bed',
    'Door',
    'Drill & Hang',
    'Windows & Curtains',
    'Cupboard & Drawer',
  ],
  'Plumber': [
    'Basin & Sink',
    'Tap & mixer',
    'Blocks & leakage',
    'Bathroom fitting',
    'Toilet & Sanitary Work',
    'Water Tank',
    'Grouting',
    'Motor',
  ],
  'Electrician': [
    'Geyser',
    'Switches & Socket',
    'Fan',
    'MCB & Fuse',
    'Wiring',
    'Light & Bulb',
    'Television',
    'Inverter & stabilizer',
    'Door bell',
    'Microwave',
    'Chandlier'
  ],
  'Cleaning': [
    'Bathroom Cleaning',
    'Full Home Deep Cleaning',
    'Commercial place Cleaning',
    'Kitchen Cleaning',
    'Appliances Cleaning',
    'Room Items Cleaning',
    'Sofa & Carpet',
  ],
  'Appliances': [
    'Television',
    'Geyser',
    'Water Purifiers',
    'Air Cooler',
    'CCTV',
  ],
  'AC service': [
    'AC Service',
    'AC Repair',
    'AC Installation',
    'AC Uninstallation',
  ],
  'Painting': [
    'Home Painting',
    'Water Proofing',
    'Gates , Windows & grill Painting',
  ],
  'Refrigerators': [
    'Single Door',
    'Double Door',
    'Side by Side',
  ],
  'Washing\nMachines': [
    'Top Load',
    'Front Load',
    'Semi Automatic',
    'Installation or Uninstallation',
  ],
};

final CustomColors = [
  lightblue,
  lightgreen,
  lightred,
  lightviolet,
  lightyellow
];

// ignore_for_file: file_names

final ProblemIcons = {
  'Carpenter': {
    'Furniture Repair': MdiIcons.tableFurniture,
    'Furniture Assembly':  MdiIcons.robotIndustrial,
    'Bed': MdiIcons.bed,
    'Door': MdiIcons.door,
    'Drill & Hang': MdiIcons.hanger,
    'Windows & Curtains': MdiIcons.curtains,
    'Cupboard & Drawer': MdiIcons.cupboard,
  },
  'Plumber': {
    'Basin & Sink': MdiIcons.countertop,
    'Tap & mixer': MdiIcons.faucet,
    'Blocks & leakage': MdiIcons.pipeLeak,
    'Bathroom fitting': MdiIcons.pipe,
    'Toilet & Sanitary Work': MdiIcons.toilet,
    'Water Tank': Icons.water_drop,
    'Grouting': Icons.kayaking,
    'Motor': MdiIcons.engine,

  },
  'Electrician': {
    'Geyser': MdiIcons.waterBoiler,
    'Switches & Socket': MdiIcons.lightSwitch,
    'Fan': MdiIcons.ceilingFan,
    'MCB & Fuse': MdiIcons.fuse,
    'Wiring': Icons.cable,
    'Light & Bulb': Icons.emoji_objects,
    'Television': MdiIcons.television,
    'Inverter & stabilizer': MdiIcons.currentDc,
    'Door bell': MdiIcons.bell,
    'Microwave': MdiIcons.microwave,
    'Chandlier': MdiIcons.ceilingLightMultiple,
  },
  'Cleaning': {
    'Bathroom Cleaning': MdiIcons.shower,
    'Full Home Deep Cleaning': MdiIcons.sprayBottle,
    'Commercial place Cleaning': MdiIcons.store,
    'Kitchen Cleaning': MdiIcons.countertop,
    'Appliances Cleaning': MdiIcons.fridge,
    'Room Items Cleaning': MdiIcons.table,
    'Sofa & Carpet': MdiIcons.sofa,
  },
  'Appliances': {
    'Television': MdiIcons.television,
    'Geyser': MdiIcons.waterBoiler,
    'Water Purifiers': MdiIcons.airConditioner,
    'Air Cooler': MdiIcons.fan,
    'CCTV': MdiIcons.cctv,
  },
  'AC service': {
    'AC Service': MdiIcons.accountWrench,
    'AC Repair': MdiIcons.wrench,
    'AC Installation': MdiIcons.shapePlus,
    'AC Uninstallation': MdiIcons.puzzleRemove,
  },
  'Painting': {
    'Home Painting': MdiIcons.formatPaint,
    'Water Proofing': MdiIcons.waterOff,
    'Gates , Windows & grill Painting': MdiIcons.door,
  },
  'Refrigerators': {
    'Single Door': MdiIcons.fridgeIndustrial,
    'Double Door': MdiIcons.fridge,
    'Side by Side': MdiIcons.fridgeVariant,
  },
  'Washing\nMachines': {
    'Top Load': MdiIcons.arrowUpBox,
    'Front Load': MdiIcons.washingMachine,
    'Semi Automatic': MdiIcons.dishwasher,
    'Installation or Uninstallation': MdiIcons.robotIndustrial,
  },
};
