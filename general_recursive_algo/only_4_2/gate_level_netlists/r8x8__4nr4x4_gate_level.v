/* Generated by Yosys 0.33 (git sha1 2584903a060) */

module FA(A, B, cin, sum, carry);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  input A;
  wire A;
  input B;
  wire B;
  output carry;
  wire carry;
  input cin;
  wire cin;
  output sum;
  wire sum;
  INV_X1 _11_ (
    .A(_06_),
    .ZN(_07_)
  );
  NAND2_X1 _12_ (
    .A1(_04_),
    .A2(_03_),
    .ZN(_08_)
  );
  XNOR2_X1 _13_ (
    .A(_04_),
    .B(_03_),
    .ZN(_09_)
  );
  XNOR2_X1 _14_ (
    .A(_06_),
    .B(_09_),
    .ZN(_10_)
  );
  OAI21_X1 _15_ (
    .A(_08_),
    .B1(_09_),
    .B2(_07_),
    .ZN(_05_)
  );
  assign _04_ = B;
  assign _03_ = A;
  assign _06_ = cin;
  assign sum = _10_;
  assign carry = _05_;
endmodule

module HA(A, B, sum, carry);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A;
  wire A;
  input B;
  wire B;
  output carry;
  wire carry;
  output sum;
  wire sum;
  AND2_X1 _4_ (
    .A1(_1_),
    .A2(_0_),
    .ZN(_2_)
  );
  XOR2_X1 _5_ (
    .A(_1_),
    .B(_0_),
    .Z(_3_)
  );
  assign _1_ = B;
  assign _0_ = A;
  assign sum = _3_;
  assign carry = _2_;
endmodule

module nr__4x4(A, B, P);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  wire _15_;
  wire _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  wire _20_;
  wire _21_;
  wire _22_;
  wire _23_;
  wire _24_;
  wire _25_;
  wire _26_;
  wire _27_;
  wire _28_;
  wire _29_;
  wire _30_;
  wire _31_;
  wire _32_;
  wire _33_;
  wire _34_;
  wire _35_;
  wire _36_;
  wire _37_;
  wire _38_;
  input [3:0] A;
  wire [3:0] A;
  input [3:0] B;
  wire [3:0] B;
  wire C23_1;
  wire C23_2;
  wire C34_1;
  wire C34_2;
  wire C45_1;
  wire C45_2;
  wire C56_2;
  wire C_12_1;
  output [7:0] P;
  wire [7:0] P;
  wire S1_1;
  wire S2_1;
  wire S2_2;
  wire S3_1;
  wire S3_2;
  wire S4_1;
  wire S4_2;
  wire S5_2;
  wire carry_3;
  wire carry_4;
  wire carry_5;
  wire carry_6;
  AND2_X1 _39_ (
    .A1(_19_),
    .A2(_15_),
    .ZN(_23_)
  );
  AND2_X1 _40_ (
    .A1(_19_),
    .A2(_16_),
    .ZN(_25_)
  );
  AND2_X1 _41_ (
    .A1(_15_),
    .A2(_20_),
    .ZN(_24_)
  );
  AND2_X1 _42_ (
    .A1(_19_),
    .A2(_17_),
    .ZN(_26_)
  );
  AND2_X1 _43_ (
    .A1(_16_),
    .A2(_20_),
    .ZN(_27_)
  );
  AND2_X1 _44_ (
    .A1(_15_),
    .A2(_21_),
    .ZN(_28_)
  );
  AND2_X1 _45_ (
    .A1(_19_),
    .A2(_18_),
    .ZN(_29_)
  );
  AND2_X1 _46_ (
    .A1(_20_),
    .A2(_17_),
    .ZN(_30_)
  );
  AND2_X1 _47_ (
    .A1(_16_),
    .A2(_21_),
    .ZN(_31_)
  );
  AND2_X1 _48_ (
    .A1(_15_),
    .A2(_22_),
    .ZN(_32_)
  );
  AND2_X1 _49_ (
    .A1(_20_),
    .A2(_18_),
    .ZN(_33_)
  );
  AND2_X1 _50_ (
    .A1(_17_),
    .A2(_21_),
    .ZN(_34_)
  );
  AND2_X1 _51_ (
    .A1(_16_),
    .A2(_22_),
    .ZN(_35_)
  );
  AND2_X1 _52_ (
    .A1(_21_),
    .A2(_18_),
    .ZN(_36_)
  );
  AND2_X1 _53_ (
    .A1(_17_),
    .A2(_22_),
    .ZN(_37_)
  );
  AND2_X1 _54_ (
    .A1(_18_),
    .A2(_22_),
    .ZN(_38_)
  );
  HA cpa_3 (
    .A(S3_2),
    .B(C23_2),
    .carry(carry_3),
    .sum(P[3])
  );
  FA cpa_4 (
    .A(S4_2),
    .B(C34_2),
    .carry(carry_4),
    .cin(carry_3),
    .sum(P[4])
  );
  FA cpa_5 (
    .A(S5_2),
    .B(C45_2),
    .carry(carry_5),
    .cin(carry_4),
    .sum(P[5])
  );
  FA cpa_6 (
    .A(_14_),
    .B(C56_2),
    .carry(carry_6),
    .cin(carry_5),
    .sum(P[6])
  );
  FA fa_2_1 (
    .A(_02_),
    .B(_03_),
    .carry(C23_1),
    .cin(_04_),
    .sum(S2_1)
  );
  FA fa_3_1 (
    .A(_05_),
    .B(_06_),
    .carry(C34_1),
    .cin(_07_),
    .sum(S3_1)
  );
  FA fa_3_2 (
    .A(S3_1),
    .B(C23_1),
    .carry(C34_2),
    .cin(_08_),
    .sum(S3_2)
  );
  FA fa_4_1 (
    .A(_09_),
    .B(_10_),
    .carry(C45_1),
    .cin(_11_),
    .sum(S4_1)
  );
  FA fa_5_2 (
    .A(_12_),
    .B(_13_),
    .carry(C56_2),
    .cin(C45_1),
    .sum(S5_2)
  );
  HA ha_1_1 (
    .A(_01_),
    .B(_00_),
    .carry(C_12_1),
    .sum(S1_1)
  );
  HA ha_2_2 (
    .A(S2_1),
    .B(C_12_1),
    .carry(C23_2),
    .sum(S2_2)
  );
  HA ha_4_2 (
    .A(S4_1),
    .B(C34_1),
    .carry(C45_2),
    .sum(S4_2)
  );
  assign { P[7], P[2:1] } = { carry_6, S2_2, S1_1 };
  assign _19_ = B[0];
  assign _15_ = A[0];
  assign P[0] = _23_;
  assign _16_ = A[1];
  assign _01_ = _25_;
  assign _20_ = B[1];
  assign _00_ = _24_;
  assign _17_ = A[2];
  assign _02_ = _26_;
  assign _03_ = _27_;
  assign _21_ = B[2];
  assign _04_ = _28_;
  assign _18_ = A[3];
  assign _05_ = _29_;
  assign _06_ = _30_;
  assign _07_ = _31_;
  assign _22_ = B[3];
  assign _08_ = _32_;
  assign _09_ = _33_;
  assign _10_ = _34_;
  assign _11_ = _35_;
  assign _12_ = _36_;
  assign _13_ = _37_;
  assign _14_ = _38_;
endmodule

module r8x8__4nr4x4(A, B, clk, P);
  wire _000_;
  wire _001_;
  wire _002_;
  wire _003_;
  wire _004_;
  wire _005_;
  wire _006_;
  wire _007_;
  wire _008_;
  wire _009_;
  wire _010_;
  wire _011_;
  wire _012_;
  wire _013_;
  wire _014_;
  wire _015_;
  wire _016_;
  wire _017_;
  wire _018_;
  wire _019_;
  wire _020_;
  wire _021_;
  wire _022_;
  wire _023_;
  wire _024_;
  wire _025_;
  wire _026_;
  wire _027_;
  wire _028_;
  wire _029_;
  wire _030_;
  wire _031_;
  wire _032_;
  wire _033_;
  wire _034_;
  wire _035_;
  wire _036_;
  wire _037_;
  wire _038_;
  wire _039_;
  wire _040_;
  wire _041_;
  wire _042_;
  wire _043_;
  wire _044_;
  wire _045_;
  wire _046_;
  wire _047_;
  wire _048_;
  wire _049_;
  wire _050_;
  wire _051_;
  wire _052_;
  wire _053_;
  wire _054_;
  wire _055_;
  wire _056_;
  wire _057_;
  wire _058_;
  wire _059_;
  wire _060_;
  wire _061_;
  wire _062_;
  wire _063_;
  wire _064_;
  wire _065_;
  wire _066_;
  wire _067_;
  wire _068_;
  wire _069_;
  wire _070_;
  wire _071_;
  wire _072_;
  wire _073_;
  wire _074_;
  wire _075_;
  wire _076_;
  wire _077_;
  wire _078_;
  wire _079_;
  wire _080_;
  wire _081_;
  wire _082_;
  wire _083_;
  wire _084_;
  wire _085_;
  wire _086_;
  wire _087_;
  wire _088_;
  wire _089_;
  wire _090_;
  wire _091_;
  wire _092_;
  wire _093_;
  wire _094_;
  wire _095_;
  wire _096_;
  wire _097_;
  wire _098_;
  wire _099_;
  wire _100_;
  wire _101_;
  wire _102_;
  wire _103_;
  wire _104_;
  wire _105_;
  wire _106_;
  wire _107_;
  wire _108_;
  wire _109_;
  wire _110_;
  wire _111_;
  wire _112_;
  wire _113_;
  wire _114_;
  wire _115_;
  wire _116_;
  wire _117_;
  wire _118_;
  wire _119_;
  wire _120_;
  wire _121_;
  wire _122_;
  wire _123_;
  wire _124_;
  wire _125_;
  wire _126_;
  wire _127_;
  wire _128_;
  wire _129_;
  wire _130_;
  wire _131_;
  wire _132_;
  wire _133_;
  wire _134_;
  wire _135_;
  wire _136_;
  wire _137_;
  wire _138_;
  wire _139_;
  wire _140_;
  wire _141_;
  wire _142_;
  wire _143_;
  wire _144_;
  wire _145_;
  wire _146_;
  wire _147_;
  wire _148_;
  wire _149_;
  wire _150_;
  wire _151_;
  wire _152_;
  wire _153_;
  wire _154_;
  wire _155_;
  wire _156_;
  wire _157_;
  wire _158_;
  wire _159_;
  wire _160_;
  wire _161_;
  wire _162_;
  wire _163_;
  wire _164_;
  wire _165_;
  wire _166_;
  wire _167_;
  wire _168_;
  wire _169_;
  wire _170_;
  wire _171_;
  wire _172_;
  wire _173_;
  wire _174_;
  wire _175_;
  wire _176_;
  wire _177_;
  wire _178_;
  wire _179_;
  wire _180_;
  wire _181_;
  wire _182_;
  wire _183_;
  wire _184_;
  wire _185_;
  wire _186_;
  wire _187_;
  wire _188_;
  wire _189_;
  wire _190_;
  input [7:0] A;
  wire [7:0] A;
  wire [3:0] A_H;
  wire [3:0] A_L;
  input [7:0] B;
  wire [7:0] B;
  wire [3:0] B_H;
  wire [3:0] B_L;
  output [15:0] P;
  wire [15:0] P;
  wire [7:0] P1;
  wire [7:0] P2;
  wire [7:0] P3;
  wire [7:0] P4;
  input clk;
  wire clk;
  INV_X1 _191_ (
    .A(_111_),
    .ZN(_138_)
  );
  AND2_X1 _192_ (
    .A1(_099_),
    .A2(_091_),
    .ZN(_139_)
  );
  XOR2_X1 _193_ (
    .A(_099_),
    .B(_091_),
    .Z(_140_)
  );
  AND2_X1 _194_ (
    .A1(_087_),
    .A2(_140_),
    .ZN(_141_)
  );
  XOR2_X1 _195_ (
    .A(_087_),
    .B(_140_),
    .Z(_121_)
  );
  NOR2_X1 _196_ (
    .A1(_139_),
    .A2(_141_),
    .ZN(_142_)
  );
  AND2_X1 _197_ (
    .A1(_100_),
    .A2(_092_),
    .ZN(_143_)
  );
  XOR2_X1 _198_ (
    .A(_100_),
    .B(_092_),
    .Z(_144_)
  );
  XOR2_X1 _199_ (
    .A(_088_),
    .B(_144_),
    .Z(_145_)
  );
  OAI21_X1 _200_ (
    .A(_145_),
    .B1(_141_),
    .B2(_139_),
    .ZN(_146_)
  );
  AOI21_X1 _201_ (
    .A(_143_),
    .B1(_144_),
    .B2(_088_),
    .ZN(_147_)
  );
  AND2_X1 _202_ (
    .A1(_101_),
    .A2(_093_),
    .ZN(_148_)
  );
  XOR2_X1 _203_ (
    .A(_101_),
    .B(_093_),
    .Z(_149_)
  );
  XNOR2_X1 _204_ (
    .A(_089_),
    .B(_149_),
    .ZN(_150_)
  );
  OR2_X1 _205_ (
    .A1(_147_),
    .A2(_150_),
    .ZN(_151_)
  );
  AND2_X1 _206_ (
    .A1(_147_),
    .A2(_150_),
    .ZN(_152_)
  );
  XOR2_X1 _207_ (
    .A(_147_),
    .B(_150_),
    .Z(_153_)
  );
  XNOR2_X1 _208_ (
    .A(_146_),
    .B(_153_),
    .ZN(_123_)
  );
  OAI21_X1 _209_ (
    .A(_151_),
    .B1(_152_),
    .B2(_146_),
    .ZN(_154_)
  );
  AOI21_X1 _210_ (
    .A(_148_),
    .B1(_149_),
    .B2(_089_),
    .ZN(_155_)
  );
  AND2_X1 _211_ (
    .A1(_102_),
    .A2(_094_),
    .ZN(_156_)
  );
  XOR2_X1 _212_ (
    .A(_102_),
    .B(_094_),
    .Z(_157_)
  );
  XNOR2_X1 _213_ (
    .A(_090_),
    .B(_157_),
    .ZN(_158_)
  );
  NOR2_X1 _214_ (
    .A1(_155_),
    .A2(_158_),
    .ZN(_159_)
  );
  XOR2_X1 _215_ (
    .A(_155_),
    .B(_158_),
    .Z(_160_)
  );
  XOR2_X1 _216_ (
    .A(_154_),
    .B(_160_),
    .Z(_124_)
  );
  AOI21_X1 _217_ (
    .A(_159_),
    .B1(_160_),
    .B2(_154_),
    .ZN(_161_)
  );
  AOI21_X1 _218_ (
    .A(_156_),
    .B1(_157_),
    .B2(_090_),
    .ZN(_162_)
  );
  AND2_X1 _219_ (
    .A1(_095_),
    .A2(_107_),
    .ZN(_163_)
  );
  XOR2_X1 _220_ (
    .A(_095_),
    .B(_107_),
    .Z(_164_)
  );
  XNOR2_X1 _221_ (
    .A(_103_),
    .B(_164_),
    .ZN(_165_)
  );
  NOR2_X1 _222_ (
    .A1(_162_),
    .A2(_165_),
    .ZN(_166_)
  );
  INV_X1 _223_ (
    .A(_166_),
    .ZN(_167_)
  );
  XOR2_X1 _224_ (
    .A(_162_),
    .B(_165_),
    .Z(_168_)
  );
  INV_X1 _225_ (
    .A(_168_),
    .ZN(_169_)
  );
  XNOR2_X1 _226_ (
    .A(_161_),
    .B(_168_),
    .ZN(_125_)
  );
  OAI21_X1 _227_ (
    .A(_167_),
    .B1(_169_),
    .B2(_161_),
    .ZN(_170_)
  );
  AOI21_X1 _228_ (
    .A(_163_),
    .B1(_164_),
    .B2(_103_),
    .ZN(_171_)
  );
  AND2_X1 _229_ (
    .A1(_096_),
    .A2(_108_),
    .ZN(_172_)
  );
  XOR2_X1 _230_ (
    .A(_096_),
    .B(_108_),
    .Z(_173_)
  );
  XNOR2_X1 _231_ (
    .A(_104_),
    .B(_173_),
    .ZN(_174_)
  );
  NOR2_X1 _232_ (
    .A1(_171_),
    .A2(_174_),
    .ZN(_175_)
  );
  XOR2_X1 _233_ (
    .A(_171_),
    .B(_174_),
    .Z(_176_)
  );
  XOR2_X1 _234_ (
    .A(_170_),
    .B(_176_),
    .Z(_126_)
  );
  AOI21_X1 _235_ (
    .A(_175_),
    .B1(_176_),
    .B2(_170_),
    .ZN(_177_)
  );
  AOI21_X1 _236_ (
    .A(_172_),
    .B1(_173_),
    .B2(_104_),
    .ZN(_178_)
  );
  AND2_X1 _237_ (
    .A1(_097_),
    .A2(_109_),
    .ZN(_179_)
  );
  XOR2_X1 _238_ (
    .A(_097_),
    .B(_109_),
    .Z(_180_)
  );
  XNOR2_X1 _239_ (
    .A(_105_),
    .B(_180_),
    .ZN(_181_)
  );
  NOR2_X1 _240_ (
    .A1(_178_),
    .A2(_181_),
    .ZN(_182_)
  );
  XOR2_X1 _241_ (
    .A(_178_),
    .B(_181_),
    .Z(_183_)
  );
  INV_X1 _242_ (
    .A(_183_),
    .ZN(_184_)
  );
  NOR2_X1 _243_ (
    .A1(_177_),
    .A2(_184_),
    .ZN(_185_)
  );
  XNOR2_X1 _244_ (
    .A(_177_),
    .B(_183_),
    .ZN(_115_)
  );
  AOI21_X1 _245_ (
    .A(_179_),
    .B1(_180_),
    .B2(_105_),
    .ZN(_186_)
  );
  AND2_X1 _246_ (
    .A1(_098_),
    .A2(_110_),
    .ZN(_187_)
  );
  XOR2_X1 _247_ (
    .A(_098_),
    .B(_110_),
    .Z(_188_)
  );
  XNOR2_X1 _248_ (
    .A(_106_),
    .B(_188_),
    .ZN(_189_)
  );
  OR2_X1 _249_ (
    .A1(_186_),
    .A2(_189_),
    .ZN(_190_)
  );
  XOR2_X1 _250_ (
    .A(_186_),
    .B(_189_),
    .Z(_127_)
  );
  OAI21_X1 _251_ (
    .A(_127_),
    .B1(_185_),
    .B2(_182_),
    .ZN(_128_)
  );
  OR3_X1 _252_ (
    .A1(_182_),
    .A2(_185_),
    .A3(_127_),
    .ZN(_129_)
  );
  AND2_X1 _253_ (
    .A1(_128_),
    .A2(_129_),
    .ZN(_116_)
  );
  AOI21_X1 _254_ (
    .A(_187_),
    .B1(_188_),
    .B2(_106_),
    .ZN(_130_)
  );
  NOR2_X1 _255_ (
    .A1(_138_),
    .A2(_130_),
    .ZN(_131_)
  );
  XNOR2_X1 _256_ (
    .A(_138_),
    .B(_130_),
    .ZN(_132_)
  );
  AOI21_X1 _257_ (
    .A(_132_),
    .B1(_128_),
    .B2(_190_),
    .ZN(_133_)
  );
  AND3_X1 _258_ (
    .A1(_190_),
    .A2(_128_),
    .A3(_132_),
    .ZN(_134_)
  );
  NOR2_X1 _259_ (
    .A1(_133_),
    .A2(_134_),
    .ZN(_117_)
  );
  NOR2_X1 _260_ (
    .A1(_131_),
    .A2(_133_),
    .ZN(_135_)
  );
  OAI21_X1 _261_ (
    .A(_112_),
    .B1(_131_),
    .B2(_133_),
    .ZN(_136_)
  );
  XNOR2_X1 _262_ (
    .A(_112_),
    .B(_135_),
    .ZN(_118_)
  );
  OAI211_X1 _263_ (
    .A(_112_),
    .B(_113_),
    .C1(_131_),
    .C2(_133_),
    .ZN(_137_)
  );
  XNOR2_X1 _264_ (
    .A(_113_),
    .B(_136_),
    .ZN(_119_)
  );
  XNOR2_X1 _265_ (
    .A(_114_),
    .B(_137_),
    .ZN(_120_)
  );
  XNOR2_X1 _266_ (
    .A(_142_),
    .B(_145_),
    .ZN(_122_)
  );
  nr__4x4 M1 (
    .A(A[3:0]),
    .B(B[3:0]),
    .P(P1)
  );
  nr__4x4 M2 (
    .A(A[7:4]),
    .B(B[3:0]),
    .P(P2)
  );
  nr__4x4 M3 (
    .A(B[7:4]),
    .B(A[3:0]),
    .P(P3)
  );
  nr__4x4 M4 (
    .A(B[7:4]),
    .B(A[7:4]),
    .P(P4)
  );
  assign A_H = A[7:4];
  assign A_L = A[3:0];
  assign B_H = B[7:4];
  assign B_L = B[3:0];
  assign P[3:0] = P1[3:0];
  assign _099_ = P3[0];
  assign _091_ = P2[0];
  assign _087_ = P1[4];
  assign P[4] = _121_;
  assign _101_ = P3[2];
  assign _093_ = P2[2];
  assign _089_ = P1[6];
  assign _100_ = P3[1];
  assign _092_ = P2[1];
  assign _088_ = P1[5];
  assign P[6] = _123_;
  assign _102_ = P3[3];
  assign _094_ = P2[3];
  assign _090_ = P1[7];
  assign P[7] = _124_;
  assign _095_ = P2[4];
  assign _107_ = P4[0];
  assign _103_ = P3[4];
  assign P[8] = _125_;
  assign _096_ = P2[5];
  assign _108_ = P4[1];
  assign _104_ = P3[5];
  assign P[9] = _126_;
  assign _097_ = P2[6];
  assign _109_ = P4[2];
  assign _105_ = P3[6];
  assign P[10] = _115_;
  assign _098_ = P2[7];
  assign _110_ = P4[3];
  assign _106_ = P3[7];
  assign P[11] = _116_;
  assign _111_ = P4[4];
  assign P[12] = _117_;
  assign _112_ = P4[5];
  assign P[13] = _118_;
  assign _113_ = P4[6];
  assign P[14] = _119_;
  assign _114_ = P4[7];
  assign P[15] = _120_;
  assign P[5] = _122_;
endmodule
