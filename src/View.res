open Operations

let show = x =>
  switch x {
  | Digit(n) => string_of_int(n)
  | Decimal => "."
  | Percent => "%"
  | Op(Add) => "+"
  | Op(Subtract) => "-"
  | Op(Multiply) => "*"
  | Op(Divide) => "/"
  | Equal => "="
  | Cancel => "C"
  | CancelEntry => "CE"
  }

module Make = (Updater: Updater.Updater) => {
  let s = Updater.name ++ "Calculator"

  @react.component
  let make = () => {
    let (state: Updater.t, dispatch) = React.useReducer(
      (state, action: Operations.action) => Updater.update(state, action),
      Updater.initialState,
    )
    let perform = (action: Operations.action) => {
      Js.log2("perform_action:", action)
      dispatch(action)
    }

    let button = action => {
      Js.log2("button_action:", action)
      <button onClick={_ => perform(action) |> ignore}> {React.string(show(action))} </button>
    }

    <table>
      <tbody>
        <tr>
          <td colSpan=6>
            <div className="readout"> {React.string(Updater.readout(state))} </div>
          </td>
        </tr>
        <tr>
          <td> {button(Digit(7))} </td>
          <td> {button(Digit(8))} </td>
          <td> {button(Digit(9))} </td>
          <td />
          <td> {button(Cancel)} </td>
          <td> {button(CancelEntry)} </td>
        </tr>
        <tr>
          <td> {button(Digit(4))} </td>
          <td> {button(Digit(5))} </td>
          <td> {button(Digit(6))} </td>
          <td />
          <td> {button(Op(Add))} </td>
          <td> {button(Op(Subtract))} </td>
        </tr>
        <tr>
          <td> {button(Digit(1))} </td>
          <td> {button(Digit(2))} </td>
          <td> {button(Digit(3))} </td>
          <td />
          <td> {button(Op(Multiply))} </td>
          <td> {button(Op(Divide))} </td>
        </tr>
        <tr>
          <td colSpan=2> {button(Digit(0))} </td>
          <td> {button(Decimal)} </td>
          <td />
          <td> {button(Equal)} </td>
          <td> {button(Percent)} </td>
        </tr>
      </tbody>
    </table>
  }
}
