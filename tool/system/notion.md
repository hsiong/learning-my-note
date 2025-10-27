# id
详见 auto-increment id

# table
## timeline view
+ date 改为 separate : 
  timeline => layout => separate start and end dates

## formula
https://techbiji.com/notion%E5%85%AC%E5%BC%8F%E5%A4%A7%E5%85%A8/

+ 字符串拼接: prop("Project") + " " + prop("Description")

### 甘特图
let(
  start, prop("Start Date"),
  finish, prop("End Date"),
  if(
    empty(start) or empty(finish),
    "",
    let(
      total, dateBetween(finish, start, "minutes"),
      current, if(now() > finish, finish, now()),
      rawElapsed, dateBetween(current, start, "minutes"),
      elapsed, if(rawElapsed < 0, 0, rawElapsed),
      p, if(total <= 0, 1, if(elapsed / total > 1, 1, elapsed / total)),
      width, 10,
      filled, floor(p * width),
      emptyCount, if(width - filled < 0, 0, width - filled),
      "|" + repeat("🟩", filled) + repeat("⬜", emptyCount) + "| " + format(round(p * 100)) + "%"
    )
  )
)
