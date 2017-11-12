class Backoffice::CategoriesController < BackofficeController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def update
  end

  def edit
  end

  def create
    @category = Category.new(params_category)

    if @category.save
      #mandar para listagem de categorias
      redirect_to backoffice_categories_path, notice: "A categoria (#{@category.description}) foi cadastrada com sucesso!"
    else
      #ficar na mesma página
      render :new
    end

  end

  private

  def params_category
    params.require(:category).permit(:description)
  end

end
