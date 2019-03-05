#include <assert.h>
#include <stdio.h>

#include <expression.h>

void t_exp_readln(char *ln, Expression *res)
{
    Expression e;
    exp_readln(&e, ln);
    assert(e.a == res->a);
    assert(e.b == res->b);
    assert(e.op == res->op);
    assert(e.id == res->id);
}

void t_exp_cal(Expression *exp, float res)
{
    assert(res == exp_cal(exp));
}

void t_exp_valid(Expression *exp, bool res)
{
    assert(res == exp_vaild(exp));
}

void t_exp_opValid(char op, bool res)
{
    assert(res == exp_opVaild(op));
}

int main()
{
    printf("Testing exp_readln...");
    {
        Expression exp;
        t_exp_readln(
            "#0 1 + 1\n",
            &(Expression){.a = 1, .op = '+', .b = 1, .id = 0});
    }
    printf("pass\n");
}