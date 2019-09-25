module ThorActionsExtend
  include Thor::Actions

  private
  def render_template(path, target_path = path)
    template path, "#{@workdir}/#{target_path.gsub('.erb', '')}"
  end

  def ask_with_default(question = '', default = '')
    result = ask(question)
    result != '' ? result : default
  end

  def append_or_create(file_path, file_content)
    if File.exist?(file_path)
      append_to_file file_path, file_content
    else
      create_file file_path, file_content
    end
  end
end