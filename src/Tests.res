open Operations

module Make = (Updater: Updater.Updater) => {
  let test = () => {
    let assertEqual = (a, b, msg) =>
      if a == b {
        ()
      } else {
        failwith(Updater.name ++ (": " ++ msg))
      }
    let after = actions =>
      Updater.readout(List.fold_left(Updater.update, Updater.initialState, actions))
    let assertResult = (name, actions, answer) => assertEqual(after(actions), answer, name)
    assertResult("Digit starts an operand", list{Digit(1)}, "1.")
    assertResult(
      "Subsequent digits add to end of operand",
      list{Digit(1), Digit(2), Digit(3)},
      "123.",
    )
    assertResult(
      "Pressing decimal makes subsequent digits move into decimal positions",
      list{Digit(1), Decimal, Digit(2), Digit(3)},
      "1.23",
    )
    assertResult(
      "After operand, percent divides number by 100",
      list{Digit(1), Digit(2), Digit(3), Percent},
      "1.23",
    )
    assertResult(
      "After percent, next digit starts a new number",
      list{Digit(2), Percent, Digit(5)},
      "5.",
    )
    assertResult(
      "After previous operation resolved, number is editable",
      list{Digit(1), Op(Add), Digit(1), Op(Add), Digit(1), Digit(1)},
      "11.",
    )
    assertResult(
      "After an operation, subtraction serves to negate the upcoming operand",
      list{Digit(5), Op(Multiply), Op(Subtract), Digit(2)},
      "-2.",
    )
    assertResult(
      "After negation, upcoming operand used correctly as negative",
      list{Digit(3), Op(Multiply), Op(Subtract), Digit(7), Equal},
      "-21.",
      // -(21.)->Js.Float.toString
    )
    assertResult(
      "After previous operation, decimal resets display",
      list{Digit(1), Op(Multiply), Digit(2), Equal, Decimal},
      "0.",
    )
  }
}
