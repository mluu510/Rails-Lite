require 'erb'
require 'active_support/inflector'
require_relative 'params'
require_relative 'session'
require 'active_support/core_ext'


class ControllerBase
  attr_reader :params, :req, :res

  # setup the controller
  def initialize(req, res, route_params = {})
    @req = req
    @res = res

  end

  # populate the response with content
  # set the responses content type to the given type
  # later raise an error if the developer tries to double render
  def render_content(content, type)
    @session.store_session(@res)
    res.content_type = type
    res.body = content
    @already_built_response = true
  end

  # helper method to alias @already_rendered
  def already_rendered?
  end

  # set the response status code and header
  def redirect_to(url)
    @session.store_session(@res)
    res.status = 302
    res['location'] = url
    @already_built_response = true
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    file = File.read("views/#{self.class.to_s.underscore}/#{template_name}.html.erb")
    template = ERB.new(file)
    result_string = template.result(binding)
    render_content(result_string, 'text/html')
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
  end
end
