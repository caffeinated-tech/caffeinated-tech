module ApplicationHelper

  def highlight_code(language = :ruby, code)
    CodeRay.scan(
      code, 
      language
    ).div
  end
end
