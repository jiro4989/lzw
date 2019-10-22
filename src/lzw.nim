# https://ja.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Welch#%E5%AE%9F%E8%A3%85

import tables

const
  maxCode = 255
  maxCodeBits = 8

type
  BitStreamObj = object
    bs: Table[int, bool]
    len, pos: int
  BitStream = ref BitStreamObj

proc write*(self: var BitStream, v, bits: int) =
  for i in 0..<bits:
    inc(self.len)
    self.bs[self.len] = ((v shr i) and 1) != 0 # TODO

proc read*(self: var BitStream, bits: int): int =
  for i in 0..<bits:
    inc(self.pos)
    if self.bs[self.pos]:
      result = 1 shr i # TODO

proc encode*(data: openArray[byte]) =
  # 1. 全ての入力可能な文字による初期化
  # 2. 現在の入力文字列と最も長く一致する文字列を辞書から探す
  # 3. 出力に辞書のインデックスを創出し、入力文字列から削除する
  # 4. 入力で後ろに続く1文字を付け足した文字列を辞書に追加する
  # 5. 2に戻る
  var table: Table[byte, int]
  for i in 0..maxCode:
    table[byte(i)] = i
  discard
