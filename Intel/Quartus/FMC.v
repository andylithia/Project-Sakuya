// MIT License
// 
// Copyright (c) 2022 andylithia
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//==============================================================================
// Frequency-Modulation Controller
// 

module FMC(
    input         inc,
    input         rst_n,
    output [19:0] dout,
    output        update
);
    localparam DSIZE   = 20;
    localparam FMWIDTH = 8;
    wire [DSIZE-1:0] incr_lut [(2**FMWIDTH)-1:0];
    assign incr_lut[  0] = 2796;
    assign incr_lut[  1] = 3331;
    assign incr_lut[  2] = 3866;
    assign incr_lut[  3] = 4401;
    assign incr_lut[  4] = 4936;
    assign incr_lut[  5] = 5472;
    assign incr_lut[  6] = 6007;
    assign incr_lut[  7] = 6542;
    assign incr_lut[  8] = 7077;
    assign incr_lut[  9] = 7612;
    assign incr_lut[ 10] = 8148;
    assign incr_lut[ 11] = 8683;
    assign incr_lut[ 12] = 9218;
    assign incr_lut[ 13] = 9753;
    assign incr_lut[ 14] = 10288;
    assign incr_lut[ 15] = 10824;
    assign incr_lut[ 16] = 11359;
    assign incr_lut[ 17] = 11894;
    assign incr_lut[ 18] = 12429;
    assign incr_lut[ 19] = 12964;
    assign incr_lut[ 20] = 13500;
    assign incr_lut[ 21] = 14035;
    assign incr_lut[ 22] = 14570;
    assign incr_lut[ 23] = 15105;
    assign incr_lut[ 24] = 15640;
    assign incr_lut[ 25] = 16176;
    assign incr_lut[ 26] = 16711;
    assign incr_lut[ 27] = 17246;
    assign incr_lut[ 28] = 17781;
    assign incr_lut[ 29] = 18316;
    assign incr_lut[ 30] = 18851;
    assign incr_lut[ 31] = 19387;
    assign incr_lut[ 32] = 19922;
    assign incr_lut[ 33] = 20457;
    assign incr_lut[ 34] = 20992;
    assign incr_lut[ 35] = 21527;
    assign incr_lut[ 36] = 22063;
    assign incr_lut[ 37] = 22598;
    assign incr_lut[ 38] = 23133;
    assign incr_lut[ 39] = 23668;
    assign incr_lut[ 40] = 24203;
    assign incr_lut[ 41] = 24739;
    assign incr_lut[ 42] = 25274;
    assign incr_lut[ 43] = 25809;
    assign incr_lut[ 44] = 26344;
    assign incr_lut[ 45] = 26879;
    assign incr_lut[ 46] = 27415;
    assign incr_lut[ 47] = 27950;
    assign incr_lut[ 48] = 28485;
    assign incr_lut[ 49] = 29020;
    assign incr_lut[ 50] = 29555;
    assign incr_lut[ 51] = 30091;
    assign incr_lut[ 52] = 30626;
    assign incr_lut[ 53] = 31161;
    assign incr_lut[ 54] = 31696;
    assign incr_lut[ 55] = 32231;
    assign incr_lut[ 56] = 32767;
    assign incr_lut[ 57] = 33302;
    assign incr_lut[ 58] = 33837;
    assign incr_lut[ 59] = 34372;
    assign incr_lut[ 60] = 34907;
    assign incr_lut[ 61] = 35442;
    assign incr_lut[ 62] = 35978;
    assign incr_lut[ 63] = 36513;
    assign incr_lut[ 64] = 37048;
    assign incr_lut[ 65] = 37583;
    assign incr_lut[ 66] = 38118;
    assign incr_lut[ 67] = 38654;
    assign incr_lut[ 68] = 39189;
    assign incr_lut[ 69] = 39724;
    assign incr_lut[ 70] = 40259;
    assign incr_lut[ 71] = 40794;
    assign incr_lut[ 72] = 41330;
    assign incr_lut[ 73] = 41865;
    assign incr_lut[ 74] = 42400;
    assign incr_lut[ 75] = 42935;
    assign incr_lut[ 76] = 43470;
    assign incr_lut[ 77] = 44006;
    assign incr_lut[ 78] = 44541;
    assign incr_lut[ 79] = 45076;
    assign incr_lut[ 80] = 45611;
    assign incr_lut[ 81] = 46146;
    assign incr_lut[ 82] = 46682;
    assign incr_lut[ 83] = 47217;
    assign incr_lut[ 84] = 47752;
    assign incr_lut[ 85] = 48287;
    assign incr_lut[ 86] = 48822;
    assign incr_lut[ 87] = 49358;
    assign incr_lut[ 88] = 49893;
    assign incr_lut[ 89] = 50428;
    assign incr_lut[ 90] = 50963;
    assign incr_lut[ 91] = 51498;
    assign incr_lut[ 92] = 52033;
    assign incr_lut[ 93] = 52569;
    assign incr_lut[ 94] = 53104;
    assign incr_lut[ 95] = 53639;
    assign incr_lut[ 96] = 54174;
    assign incr_lut[ 97] = 54709;
    assign incr_lut[ 98] = 55245;
    assign incr_lut[ 99] = 55780;
    assign incr_lut[100] = 56315;
    assign incr_lut[101] = 56850;
    assign incr_lut[102] = 57385;
    assign incr_lut[103] = 57921;
    assign incr_lut[104] = 58456;
    assign incr_lut[105] = 58991;
    assign incr_lut[106] = 59526;
    assign incr_lut[107] = 60061;
    assign incr_lut[108] = 60597;
    assign incr_lut[109] = 61132;
    assign incr_lut[110] = 61667;
    assign incr_lut[111] = 62202;
    assign incr_lut[112] = 62737;
    assign incr_lut[113] = 63273;
    assign incr_lut[114] = 63808;
    assign incr_lut[115] = 64343;
    assign incr_lut[116] = 64878;
    assign incr_lut[117] = 65413;
    assign incr_lut[118] = 65948;
    assign incr_lut[119] = 66484;
    assign incr_lut[120] = 67019;
    assign incr_lut[121] = 67554;
    assign incr_lut[122] = 68089;
    assign incr_lut[123] = 68624;
    assign incr_lut[124] = 69160;
    assign incr_lut[125] = 69695;
    assign incr_lut[126] = 70230;
    assign incr_lut[127] = 70765;
    assign incr_lut[128] = 71300;
    assign incr_lut[129] = 71836;
    assign incr_lut[130] = 72371;
    assign incr_lut[131] = 72906;
    assign incr_lut[132] = 73441;
    assign incr_lut[133] = 73976;
    assign incr_lut[134] = 74512;
    assign incr_lut[135] = 75047;
    assign incr_lut[136] = 75582;
    assign incr_lut[137] = 76117;
    assign incr_lut[138] = 76652;
    assign incr_lut[139] = 77188;
    assign incr_lut[140] = 77723;
    assign incr_lut[141] = 78258;
    assign incr_lut[142] = 78793;
    assign incr_lut[143] = 79328;
    assign incr_lut[144] = 79864;
    assign incr_lut[145] = 80399;
    assign incr_lut[146] = 80934;
    assign incr_lut[147] = 81469;
    assign incr_lut[148] = 82004;
    assign incr_lut[149] = 82539;
    assign incr_lut[150] = 83075;
    assign incr_lut[151] = 83610;
    assign incr_lut[152] = 84145;
    assign incr_lut[153] = 84680;
    assign incr_lut[154] = 85215;
    assign incr_lut[155] = 85751;
    assign incr_lut[156] = 86286;
    assign incr_lut[157] = 86821;
    assign incr_lut[158] = 87356;
    assign incr_lut[159] = 87891;
    assign incr_lut[160] = 88427;
    assign incr_lut[161] = 88962;
    assign incr_lut[162] = 89497;
    assign incr_lut[163] = 90032;
    assign incr_lut[164] = 90567;
    assign incr_lut[165] = 91103;
    assign incr_lut[166] = 91638;
    assign incr_lut[167] = 92173;
    assign incr_lut[168] = 92708;
    assign incr_lut[169] = 93243;
    assign incr_lut[170] = 93779;
    assign incr_lut[171] = 94314;
    assign incr_lut[172] = 94849;
    assign incr_lut[173] = 95384;
    assign incr_lut[174] = 95919;
    assign incr_lut[175] = 96455;
    assign incr_lut[176] = 96990;
    assign incr_lut[177] = 97525;
    assign incr_lut[178] = 98060;
    assign incr_lut[179] = 98595;
    assign incr_lut[180] = 99130;
    assign incr_lut[181] = 99666;
    assign incr_lut[182] = 100201;
    assign incr_lut[183] = 100736;
    assign incr_lut[184] = 101271;
    assign incr_lut[185] = 101806;
    assign incr_lut[186] = 102342;
    assign incr_lut[187] = 102877;
    assign incr_lut[188] = 103412;
    assign incr_lut[189] = 103947;
    assign incr_lut[190] = 104482;
    assign incr_lut[191] = 105018;
    assign incr_lut[192] = 105553;
    assign incr_lut[193] = 106088;
    assign incr_lut[194] = 106623;
    assign incr_lut[195] = 107158;
    assign incr_lut[196] = 107694;
    assign incr_lut[197] = 108229;
    assign incr_lut[198] = 108764;
    assign incr_lut[199] = 109299;
    assign incr_lut[200] = 109834;
    assign incr_lut[201] = 110370;
    assign incr_lut[202] = 110905;
    assign incr_lut[203] = 111440;
    assign incr_lut[204] = 111975;
    assign incr_lut[205] = 112510;
    assign incr_lut[206] = 113045;
    assign incr_lut[207] = 113581;
    assign incr_lut[208] = 114116;
    assign incr_lut[209] = 114651;
    assign incr_lut[210] = 115186;
    assign incr_lut[211] = 115721;
    assign incr_lut[212] = 116257;
    assign incr_lut[213] = 116792;
    assign incr_lut[214] = 117327;
    assign incr_lut[215] = 117862;
    assign incr_lut[216] = 118397;
    assign incr_lut[217] = 118933;
    assign incr_lut[218] = 119468;
    assign incr_lut[219] = 120003;
    assign incr_lut[220] = 120538;
    assign incr_lut[221] = 121073;
    assign incr_lut[222] = 121609;
    assign incr_lut[223] = 122144;
    assign incr_lut[224] = 122679;
    assign incr_lut[225] = 123214;
    assign incr_lut[226] = 123749;
    assign incr_lut[227] = 124285;
    assign incr_lut[228] = 124820;
    assign incr_lut[229] = 125355;
    assign incr_lut[230] = 125890;
    assign incr_lut[231] = 126425;
    assign incr_lut[232] = 126961;
    assign incr_lut[233] = 127496;
    assign incr_lut[234] = 128031;
    assign incr_lut[235] = 128566;
    assign incr_lut[236] = 129101;
    assign incr_lut[237] = 129636;
    assign incr_lut[238] = 130172;
    assign incr_lut[239] = 130707;
    assign incr_lut[240] = 131242;
    assign incr_lut[241] = 131777;
    assign incr_lut[242] = 132312;
    assign incr_lut[243] = 132848;
    assign incr_lut[244] = 133383;
    assign incr_lut[245] = 133918;
    assign incr_lut[246] = 134453;
    assign incr_lut[247] = 134988;
    assign incr_lut[248] = 135524;
    assign incr_lut[249] = 136059;
    assign incr_lut[250] = 136594;
    assign incr_lut[251] = 137129;
    assign incr_lut[252] = 137664;
    assign incr_lut[253] = 138200;
    assign incr_lut[254] = 138735;
    assign incr_lut[255] = 139270;
    
    localparam DIV_FACTOR = 731;
    reg [$clog2(DIV_FACTOR):0] div_r;
    reg [7:0]                  acc_muxsel_r;
    reg                        update_r;
    // assign update = update_r;
    always @(posedge inc or negedge rst_n) begin
        if(~rst_n) begin
            div_r        <= 0;
            acc_muxsel_r <= 0;
            update_r     <= 0;
        end else if(div_r>=DIV_FACTOR) begin
            div_r        <= 0;
            acc_muxsel_r <= acc_muxsel_r + 1;
            update_r <= 1;
        end else begin
            div_r        <= div_r + 1;
            acc_muxsel_r <= acc_muxsel_r;
            update_r <= 0;
        end
    end
	 assign update = acc_muxsel_r == 0;
    assign dout = incr_lut[acc_muxsel_r];
endmodule /* FMC */