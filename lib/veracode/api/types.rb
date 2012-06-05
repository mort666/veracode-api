require 'base64'

module Veracode
  module Result
    class Base
      include ROXML
    end
    
    class Screenshot < Base
      xml_reader :format, :from => "@format"
      
      xml_reader(:data) {|b64data| Base64.decode(b64data) }
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
  end
end