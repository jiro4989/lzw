# https://ja.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Welch#%E5%AE%9F%E8%A3%85

import tables

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
