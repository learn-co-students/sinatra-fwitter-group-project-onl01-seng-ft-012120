class Helpers 

  def self.params_empty?(params)
    params.any? do |k,v|
    v.empty?
    end
  end

  def self.is_logged_in?(session)
    !!session[:id]
  end
end