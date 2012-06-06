require 'base64'
require 'roxml'

module Veracode
  module Result
    class Base
      include ROXML
    end
    
    class Screenshot < Base
      xml_reader :format, :from => "@format"
      
      xml_reader(:data) {|b64data| Base64.decode64(b64data) }
    end
    
    class BulletType < Base
      xml_reader :text, :from => "@text"
    end
    
    class ParaType  < Base
      xml_reader :bulletitem, :as => [BulletType]
      xml_reader :text, :from => "@text"
    end
    
    class TextType < Base
      xml_reader :text, :from => "text/@text"
    end
    
    class Para < Base
      xml_reader :para, :as => [ParaType]
    end
    
    class AppendixType < Base
      xml_reader :description
      xml_reader :screenshot, :as => [Screenshot]
      xml_reader :code
    end
  end
end