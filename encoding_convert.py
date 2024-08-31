import codecs
import argparse
import sys
import os
import pathlib

def main():

  parser = argparse.ArgumentParser(
    prog='Converter',
    description='Parses files from ANSI to UTF-8 and reverse',
    )
  parser.add_argument("--file", "-f", help="Filepath to read or convertfile to")
  parser.add_argument("--operation", "-o", help="read or convert")
  parsed_args = parser.parse_args(sys.argv[1:])

  if parsed_args.file is None:
    print("--file is missing.")
    exit(1)

  if parsed_args.operation is None:
    print("--operation is missing.")
    exit(1)
  elif parsed_args.operation != "read" and parsed_args.operation != "convert":
    print("--operation is not read or convert .")
    exit(1)

  print(parsed_args.file)

  #read input file
  if parsed_args.operation == "read":
    with open(parsed_args.file, 'r') as file:
      content = file.read()
      print(content)

  elif parsed_args.operation == "convert":
    #cp1252
    #write output file
    #filecontent = ""
    #with open(parsed_args.file, 'r') as file:
    #  filecontent = file.read()
    #os.remove(parsed_args.file)
    #outputpath = pathlib.Path(parsed_args.file)
    #outputpath.write_text(filecontent, encoding = 'cp1252')
    #with codecs.open(parsed_args.file, 'w', encoding = 'cp1252') as file:
    #  file.write(filecontent)
    with open(parsed_args.file,encoding='utf8') as fin:
      with open(parsed_args.file + "temp",'w',encoding='cp1252') as fout:
       fout.write(fin.read())
    os.remove(parsed_args.file)
    os.rename(parsed_args.file + "temp", parsed_args.file)

if __name__ == "__main__":
    main()