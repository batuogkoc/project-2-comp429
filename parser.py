import os
import re
import csv

def extract_values_from_filename(filename):
    match = re.match(r"mcubes-n(\d+)-f(\d+)-b(\d+)-t(\d+).txt", filename)
    if match:
        return map(int, match.groups())
    else:
        return None

def extract_time_from_file(file_path, part):
    with open(file_path, 'r') as file:
        content = file.read()
        match = re.search(fr"{part}[\s\S]*?Total:\s+(\d+\.\d+)", content)
        if match:
            return float(match.group(1))
        else:
            return None

def process_files(directory):
    data = []

    for filename in os.listdir(directory):
        if filename.endswith(".txt"):
            print(filename)
            n, f, b, t = extract_values_from_filename(filename)
            print(n, f, b, t)
            file_path = os.path.join(directory, filename)

            part1_2_time = extract_time_from_file(file_path, "Part1&2")
            part3_time = extract_time_from_file(file_path, "Part3")
            part4_time = extract_time_from_file(file_path, "Part4")
            print(part1_2_time)
            if None not in (n, f, b, t, part1_2_time, part3_time, part4_time):
                data.append([n, f, b, t, part1_2_time, part3_time, part4_time])

    return data

def write_to_csv(data, output_file):
    with open(output_file, 'w', newline='') as csvfile:
        csv_writer = csv.writer(csvfile)
        csv_writer.writerow(["N", "F", "B", "T", "Part1&2", "Part3", "Part4"])
        csv_writer.writerows(data)

if __name__ == "__main__":
    directory = "./exp2"  # Set the directory where your files are located
    output_file = "output2.csv"  # Set the desired output CSV file name

    data = process_files(directory)
    write_to_csv(data, output_file)
