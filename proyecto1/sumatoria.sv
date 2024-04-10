
module sumatoria(input logic [15:0][31:0] rd, output logic [31:0] sum);
	logic[31:0] result = 0;

	logic[15:0][14:0] negatives = 0;
	logic[15:0][14:0] positives = 0;

	logic [14:0] positive_val = 0;
	logic [14:0] negative_val = 0;

	always @* begin
		if(rd[15][15]) begin
			positives[15][14:0] = 0;
			negatives[15][14:0] = rd[15][14:0];
		end
		else begin
			negatives[15][14:0] = 0;
			positives[15][14:0] = rd[15][14:0];
		end

		if(rd[14][15]) begin
			positives[14][14:0] = 0;
			negatives[14][14:0] = rd[14][14:0];
		end
		else begin
			negatives[14][14:0] = 0;
			positives[14][14:0] = rd[14][14:0];
		end

		if(rd[13][15]) begin
			positives[13][14:0] = 0;
			negatives[13][14:0] = rd[13][14:0];
		end
		else begin
			negatives[13][14:0] = 0;
			positives[13][14:0] = rd[13][14:0];
		end

		if(rd[12][15]) begin
			positives[12][14:0] = 0;
			negatives[12][14:0] = rd[12][14:0];
		end
		else begin
			negatives[12][14:0] = 0;
			positives[12][14:0] = rd[12][14:0];
		end

		if(rd[11][15]) begin
			positives[11][14:0] = 0;
			negatives[11][14:0] = rd[11][14:0];
		end
		else begin
			negatives[11][14:0] = 0;
			positives[11][14:0] = rd[11][14:0];
		end

		if(rd[10][15]) begin
			positives[10][14:0] = 0;
			negatives[10][14:0] = rd[10][14:0];
		end
		else begin
			negatives[10][14:0] = 0;
			positives[10][14:0] = rd[10][14:0];
		end

		if(rd[9][15]) begin
			positives[9][14:0] = 0;
			negatives[9][14:0] = rd[9][14:0];
		end
		else begin
			negatives[9][14:0] = 0;
			positives[9][14:0] = rd[9][14:0];
		end

		if(rd[8][15]) begin
			positives[8][14:0] = 0;
			negatives[8][14:0] = rd[8][14:0];
		end
		else begin
			negatives[8][14:0] = 0;
			positives[8][14:0] = rd[8][14:0];
		end

		if(rd[7][15]) begin
			positives[7][14:0] = 0;
			negatives[7][14:0] = rd[7][14:0];
		end
		else begin
			negatives[7][14:0] = 0;
			positives[7][14:0] = rd[7][14:0];
		end

		if(rd[6][15]) begin
			positives[6][14:0] = 0;
			negatives[6][14:0] = rd[6][14:0];
		end
		else begin
			negatives[6][14:0] = 0;
			positives[6][14:0] = rd[6][14:0];
		end

		if(rd[5][15]) begin
			positives[5][14:0] = 0;
			negatives[5][14:0] = rd[5][14:0];
		end
		else begin
			negatives[5][14:0] = 0;
			positives[5][14:0] = rd[5][14:0];
		end

		if(rd[4][15]) begin
			positives[4][14:0] = 0;
			negatives[4][14:0] = rd[4][14:0];
		end
		else begin
			negatives[4][14:0] = 0;
			positives[4][14:0] = rd[4][14:0];
		end

		if(rd[3][15]) begin
			positives[3][14:0] = 0;
			negatives[3][14:0] = rd[3][14:0];
		end
		else begin
			negatives[3][14:0] = 0;
			positives[3][14:0] = rd[3][14:0];
		end

		if(rd[2][15]) begin
			positives[2][14:0] = 0;
			negatives[2][14:0] = rd[2][14:0];
		end
		else begin
			negatives[2][14:0] = 0;
			positives[2][14:0] = rd[2][14:0];
		end

		if(rd[1][15]) begin
			positives[1][14:0] = 0;
			negatives[1][14:0] = rd[1][14:0];
		end
		else begin
			negatives[1][14:0] = 0;
			positives[1][14:0] = rd[1][14:0];
		end

		if(rd[0][15]) begin
			positives[0][14:0] = 0;
			negatives[0][14:0] = rd[0][14:0];
		end
		else begin
			negatives[0][14:0] = 0;
			positives[0][14:0] = rd[0][14:0];
		end

		positive_val = positives[15] + positives[14] + positives[13] + positives[12] + positives[11] + positives[10] + positives[9] + positives[8] + positives[7] + positives[6] + positives[5] + positives[4] + positives[3] + positives[2] + positives[1] + positives[0];

		negative_val = negatives[15] + negatives[14] + negatives[13] + negatives[12] + negatives[11] + negatives[10] + negatives[9] + negatives[8] + negatives[7] + negatives[6] + negatives[5] + negatives[4] + negatives[3] + negatives[2] + negatives[1] + negatives[0];


		if(positive_val > negative_val)begin
			result[15] = 0;
			result[14:0] = positive_val - negative_val;
		end
		else begin
			result[15] = 1;
			result[14:0] = negative_val - positive_val;
		end
	end

	assign sum = result;

endmodule