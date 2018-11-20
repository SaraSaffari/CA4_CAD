//if compile in window uncommnet next line.
//#include "stdafx.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int W = 320;
int H = 240;

int read_sram(char sram_init[], unsigned int * sram, int size); // sram[i]: 16 bit is valid.((data[7:0]) + (data[7:0]<<8))
int write_image(char output_filename[], unsigned int * rgb); // rgb[i]: 24 bit is valid. (r + (g<<8) + (b<<16) )
void pixel_reorder(unsigned int *  sram, unsigned int * rgb); // sram and rgb 

int main(void){
	unsigned int * sram, *rgb;
	char fileName[50] = "../file/ca3_board.dat";
	char outputFileName[50] = "result_file.bmp";

	sram = (unsigned int *)malloc(W*H * 3 / 2 * sizeof(unsigned int));
	read_sram(fileName, sram, W*H * 3 / 2);
	printf("read sram done.\n");
	
	rgb = (unsigned int *)malloc(W*H * sizeof(unsigned int));
	pixel_reorder(sram, rgb);
	printf("pixel reorder done.\n");
	
	write_image(outputFileName, rgb);
	printf("write image done.\n");
	return 0;
   
}

void pixel_reorder(unsigned int *  sram, unsigned int * rgb){ // sram and rgb 
	int h, w ;	
	int rr, gg, bb;
	int r, g, b;
	// Offset of R, G and B color in SRAM
	int rr_offset = 0;
	int gg_offset = H * W / 2;
	int bb_offset = H * W;
	
	for (h=0; h<H; h++)
		for (w=0; w<W; w=w+2){
			// Get R2R1
			rr = sram[rr_offset + (h*W + w) / 2];
			
			// Get G2G1
			gg = sram[gg_offset + (h*W + w) / 2];
			
			// Get B2B1
			bb = sram[bb_offset + (h*W + w) / 2];
			
			// Extract R1,G1 and B1
			r = rr & 0x00ff;
			g = gg & 0x00ff;
			b = bb & 0x00ff;
			
			// Set RGB1
			rgb[h*W + w] = r + (g << 8) + (b << 16) ;
			
			// Extract R2,G2 and B2
			r = rr >> 8;
			g = gg >> 8;
			b = bb >> 8;
			
			// Set RGB2
			rgb[h*W + w + 1] = r + ( g<<8 ) + ( b <<16 ) ;
		}
}

int write_image(char output_filename[] , unsigned int * rgb){ // rgb[i]: 24 bit is valid. (r + (g<<8) + (b<<16) )
	int i,h , w ;
	FILE *fp;
	unsigned char header[54] ;
	
	// Initialize header of bmp to zero.
	for (i=0; i<54; i++)
		header[i] = 0;
	// Initialize header of bmp file.
	header[0]= 0x42;
	header[1]= 0x4d;
	header[2]= 0x36;
	header[3]= 0x84;
	header[4]= 0x01;
	header[10]= 0x36;
	header[14]= 0x28;
	header[18]= W; 
	header[19]= W >> 8; 
	header[20]= W >> 16;
	header[21]= W >> 24;
	header[22]= H; 
	header[23]= H >> 8; 
	header[24]= H >> 16;
	header[25]= H >> 24;
	header[26]= 0x01;
	header[28]= 0x18;
	header[35]= 0x84;
	header[36]= 0x03;
	
	fp = fopen(output_filename,"wb");
	
	if(!fp){
			printf("Can not create bmp file for output.");
	}
	// Write header of bmp file.
	for (i=0; i<54; i++){
		fprintf(fp, "%c",header[i]);
	}
	
	// Write RGB 
	// These are the actual image data, represented by consecutive rows, or "scan lines," of the bitmap. 
	// Each scan line consists of consecutive bytes representing the pixels in the scan line, in left-to-right order. 
	// The system maps pixels beginning with the bottom scan line of the rectangular region and ending with the top scan line.
	for (h=0; h<H; h++)
		for (w=0; w<W; w++)
			fprintf(fp, "%c%c%c",rgb[(H - h - 1)*W + w] >> 16, rgb[(H - h - 1)*W + w] >> 8, rgb[(H - h - 1)*W + w]);
	fclose(fp);
}

 int read_sram(char sram_init_filename[], unsigned int  * sram,  int size){ // sram[i]: 16 bit is valid.((data[7:0]) + (data[7:0]<<8))

	int i ;
	FILE *fp;
	fp = fopen(sram_init_filename, "r");
	if(!fp){
			printf("File name for SRAM_INIT not valid.");
			return 0;
	}
	
	//sram = (unsigned int *)malloc(size*sizeof(unsigned int));
	for (i=0; i<size; i++){
		fscanf(fp, "%x", &sram[i]);
	}
	return 1;
}
