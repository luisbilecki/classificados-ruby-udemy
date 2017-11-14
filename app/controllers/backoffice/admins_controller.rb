class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: [:edit, :update, :destroy]
  after_action :verify_authorized, only: :new
  after_action :verify_policy_scoped, only: :index

  def index
    @admins = policy_scope(Admin)
    #@admins = Admin.with_full_access
    #@admins = Admin.with_restricted_access
  end

  def new
    @admin = Admin.new
    authorize @admin
  end

  def update
    if @admin.update(params_admin)
      redirect_to backoffice_admins_path, notice: "O administrador (#{@admin.email}) foi atualizado com sucesso!"
    else
      render :edit
    end

  end

  def edit
  end

  def destroy
    admin_email = @admin.email

    if @admin.destroy
      #mandar para listagem de categorias
      redirect_to backoffice_admins_path, notice: "O administrador (#{admin_email}) foi excluído com sucesso!"
    else
      render :index
    end
  end

  def create
    @admin = Admin.new(params_admin)

    if @admin.save
      #mandar para listagem de categorias
      redirect_to backoffice_admins_path, notice: "O administrador (#{@admin.email}) foi cadastrado com sucesso!"
    else
      #ficar na mesma página
      render :new
    end

  end


  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def params_admin
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].except!(:password, :password_confirmation)
    end
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end
end
