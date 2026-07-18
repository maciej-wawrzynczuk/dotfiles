return {
	"David-Kunz/gen.nvim",
	opts = {
		model = "gemma3:4b",
	},
	config = function(_, opts)
		local gen = require("gen")
		gen.setup(opts)

		-- 1. Grammar & Style Fix (Replaces text)
		gen.prompts["Fix_Writing"] = {
			prompt = "Review the following text for grammar, spelling, and style. "
				.. "Make it professional and clear. Output ONLY the corrected text:\n$text",
			replace = true,
		}

		-- 2. Reformat to 80 Cols (Replaces text)
		gen.prompts["Reformat_80"] = {
			prompt = "Reformat the following text to a maximum width of 80 characters. "
				.. "Do not change the wording, only the line breaks. Output ONLY the reformatted text:\n$text",
			replace = true,
		}
	end,
}
