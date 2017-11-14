class Backoffice::CategoriesController < BackofficeController
  before_action :set_category, only: [:edit, :update]
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def update
    if @category.update(params_category)
      redirect_to backoffice_categories_path, notice: "A categoria (#{@category.description}) foi atualizada com sucesso!"
    else
      render :edit
    end

  end

  def edit
  end

  def create
    @category = CategoryService.create(params_category)

    unless @category.errors.any?
      #mandar para listagem de categorias
      redirect_to backoffice_categories_path, notice: "A categoria (#{@category.description}) foi cadastrada com sucesso!"
    else
      #ficar na mesma página
      render :new
    end

  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def params_category
      params.require(:category).permit(:description)
    end

end
