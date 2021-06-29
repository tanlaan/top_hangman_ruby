def write_to_file(contents, file_path)
    # Delete the file if it already exists
    File.delete(file_path) if File.exist?(file_path)

    # Write the contents to the file_path passed in
    File.open(file_path,'w') do |f|
        f.write(contents)
    end
end
