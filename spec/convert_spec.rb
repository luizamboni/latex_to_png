require "spec_helper"

describe "" do 

	after(:each) do
		# %x(rm #{ROOT_DIR_SPEC}/support/*.png)
	end

	context "convert.size_in_points" do
		it "com valor exato" do 
		
			image = LatexToPng::Convert.new(filename: "#{ROOT_DIR_SPEC}/support/flux.tex")
			
			expect(image.size_in_points("12px")).to eq "9pt"

		end

		it "com valor inexato pontos arredondadndo" do 
		
			image = LatexToPng::Convert.new(filename: "#{ROOT_DIR_SPEC}/support/flux.tex")
			
			expect(image.size_in_points("18px")).to eq "14pt"

		end


	end


	it "dirname do arquivo" do 
	
		image = LatexToPng::Convert.new(filename: "#{ROOT_DIR_SPEC}/support/flux.tex")
		
		expect(image.dirname).to eq "#{ROOT_DIR_SPEC}/support"
		expect(image.basename).to eq "flux"


	end

	it "dirname do arquivo" do 
	
		image = LatexToPng::Convert.new(filename: "#{ROOT_DIR_SPEC}/support/flux.tex")
		image = image.to_png
		expect(image.class).to eq File

		File.delete image.path
	end

	it "dirname do arquivo com \\cancel" do 
	
		image = LatexToPng::Convert.new(filename: "#{ROOT_DIR_SPEC}/support/cancel_example.tex")
		image = image.to_png

		expect(image.class).to eq File
		File.delete image.path

	end
	
	context "formula com usando template" do

		it "fração simples" do 
		
			image = LatexToPng::Convert.new(formula: "\\frac{a}{b}")
			image = image.to_png

			expect(image.class).to eq File
			expect(File.exist? image).to eq true

			File.delete image.path
		end

		it "fração com \\cdot" do 
		
			image = LatexToPng::Convert.new(formula: "\\frac{a}{b}\\cdot\\frac{b}{a}")
			image = image.to_png

			expect(image.class).to eq File
			expect(File.exist? image).to eq true

			File.delete image.path
		end

		it "fração com \\cdot e espaços" do 
		
			image = LatexToPng::Convert.new(formula: "\\frac{a}{b} \\cdot \\frac{b}{a}")
			image = image.to_png

			expect(image.class).to eq File
			expect(File.exist? image).to eq true

			File.delete image.path
		end

		it "fração com \\cdot e espaços e tab" do 
		
			image = LatexToPng::Convert.new(formula: "\\frac{a}{b} 		\\cdot 		\\frac{b}{a}")
			image = image.to_png

			expect(image.class).to eq File
			expect(File.exist? image).to eq true

			File.delete image.path
		end

		it "fração com tamanho de fonte" do 
		
			image = LatexToPng::Convert.new(formula: "\\frac{a}{b}", size_in_pixels: "19px")
			image = image.to_png

			expect(image.class).to eq File
			expect(File.exist? image).to eq true

			# File.delete image.path
		end

		it "insstrução inexistente como \\blabla" do 
		
			image = LatexToPng::Convert.new(formula: "\\blabla")
			expect{image.to_png}.to raise_error
		end

	end
end