require 'erb'
require 'json'
require 'ostruct'
require 'date'

def generate(data_path, template_path, output_path)
  serialized_student_groups = File.read(data_path)
  student_groups = JSON.parse(serialized_student_groups)

  template = File.read(template_path)
  generated = ERB.new(template).result(student_groups.instance_eval { binding })
  File.write(output_path, generated)
end