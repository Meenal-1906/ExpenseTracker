import 'package:flutter/material.dart';
import 'package:fourth_app/models/expense.dart';
class NewExpense extends StatefulWidget
{ 
   const NewExpense({super.key, required this.onAddExpense});
   final void Function(Expense expense) onAddExpense;
       @override
       State<NewExpense> createState()
       {
           return _NewExpenseState();
       }
}
class _NewExpenseState extends State<NewExpense>
{
   final _titleController = TextEditingController();
   final _amountcontroller = TextEditingController();
   DateTime? _selectedDate;
   Category _selectedcategory = Category.leisure;
   void _presentDatePicker() async 
   {
    final now = DateTime.now();
    final firstDate= DateTime(now.year-1, now.month,now.day);
    final pickedDate = await  showDatePicker(
      context: context, initialDate: now,firstDate: firstDate, lastDate: now);
      setState(() {
        _selectedDate = pickedDate;
      });
   }
   void _submitExpensedata() {
    final enteredamount = double.tryParse(_amountcontroller.text);
    final amountisinvalid = enteredamount == null || enteredamount<=0;
          if(_titleController.text.trim().isEmpty || amountisinvalid || _selectedDate==null)
          {
              showDialog(context: context, builder: (ctx) => AlertDialog(
                title: const Text('Invalid input'),
                content: const Text('Please make sure a valid title, amount, date and category was entered'),
                actions: [
                  TextButton(onPressed: () {
                    Navigator.pop(ctx);
                  }, child: const Text('Okay'),),
                ],
              ),);
              return;
          }
          widget.onAddExpense(Expense(
            title: _titleController.text, 
            amount: enteredamount, 
            date: _selectedDate!, 
            category: _selectedcategory
            ),
            );
            Navigator.pop(context);
   }
   @override
   void dispose()
   {
    _titleController.dispose();
    _amountcontroller.dispose();
    super.dispose();
   }
    @override
    Widget build(BuildContext context)
    {
      final keyboard = MediaQuery.of(context).viewInsets.bottom;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16,48,16,keyboard+16),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                  ),
                  Row(
                    children: [
                       Expanded(
                        child: TextField(
                         controller: _amountcontroller,
                         keyboardType: TextInputType.number,
                         decoration: const InputDecoration
                         (
                         prefixText: 'Rs ',
                         label: Text('Amount'),
                         ),
                        ),
                       ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(_selectedDate==null ? 'No selected date' : formatter.format(_selectedDate!),),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month),
                                ),
                            ],
                          ),
                        ),
                       ],
                     ),
                     const SizedBox(height: 16),
                  Row(children: [
                    DropdownButton(
                      value: _selectedcategory,
                      items: Category.values.map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase(),),),
                      ).toList(), 
                      onChanged: (value) {
                        if(value == null)
                        {
                          return ;
                        }
                        setState(() {
                          _selectedcategory = value;
                        });
                      }
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: ()
                       {
                         Navigator.pop(context);
                       }, 
                      child: const Text('Cancel'),
                      ),
                     ElevatedButton(
                      onPressed: _submitExpensedata,
                     child: const Text('Save Expense'),),
                  ],
                  ),
                ],
              ),
            ),
          ),
        );
    }
}