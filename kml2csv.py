import xml.etree.ElementTree as ET
import csv

def extract_coordinates_from_kml(kml_file):
    # Parse the KML file
    tree = ET.parse(kml_file)
    root = tree.getroot()

    # Define the namespace (if any)
    namespace = {'kml': 'http://www.opengis.net/kml/2.2'}

    # Dictionary to store the coordinates for each placement ID
    coordinates_dict = {}

    # Iterate through each Placemark element
    for placemark in root.findall('.//kml:Placemark', namespace):
        # Get the placement ID
        placement_id = placemark.get('id')

        # Find the LineString element within the Placemark
        linestring = placemark.find('.//kml:LineString', namespace)
        if linestring is not None:
            # Get the coordinates
            coordinates = linestring.find('.//kml:coordinates', namespace)
            if coordinates is not None:
                # Store the coordinates in the dictionary
                coordinates_dict[placement_id] = coordinates.text.strip()

    return coordinates_dict

def write_coordinates_to_csv(coordinates_dict, csv_file):
    # Open the CSV file for writing
    with open(csv_file, mode='w', newline='') as file:
        writer = csv.writer(file)
        # Write the header
        writer.writerow(["placement_id", "lat", "lon", "height"])

        # Write the coordinates
        for placement_id, coords in coordinates_dict.items():
            # Split the coordinates into individual points
            points = coords.split()
            for point in points:
                lat, lon, height = point.split(',')
                writer.writerow([placement_id, lat.strip(), lon.strip(), height.strip()])

# Example usage
kml_file_path = "F:\\work\\sound_work\\21032025_flies\\2025-03-21_20050_2_gps.kml"
csv_file_path = "F:\\work\\sound_work\\21032025_flies\\2025-03-21_20050_2_gps.csv"
coordinates = extract_coordinates_from_kml(kml_file_path)
write_coordinates_to_csv(coordinates, csv_file_path)

# Print the extracted coordinates
for placement_id, coords in coordinates.items():
    print(f"Placement ID: {placement_id}")
    print(f"Coordinates: {coords}")
    print()
