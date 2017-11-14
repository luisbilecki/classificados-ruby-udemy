class Admin < ActiveRecord::Base
  enum role: [ :full_access, :restricted_access ]

  #Criar escopo usando o lambda
  scope :with_full_access, -> { where(role: 'full_access') }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  #Transforma enum em string
  def role_br
    if self.role == 'full_access'
      'Acesso Completo'
    else
      'Acesso Restrito'
    end
  end
end
