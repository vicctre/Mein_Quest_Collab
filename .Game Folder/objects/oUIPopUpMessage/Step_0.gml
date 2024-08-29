
for (var i = 0; i < array_length(messages); ++i) {
    var item = messages[i]
    item.step()
    if item.is_done {
        array_delete(messages, i, 1)
        i--
    }
}
