<?php

namespace app\models\forms;

use yii\base\Model;
use app\models\Users;
use Yii;

class LoginForm extends Model
{
    public string $email = '';
    public string $password = '';
    private $_user;

    /**
     * @return string[]
     */
    public function attributeLabels(): array
    {
        return [
            'email' => 'Эл. почта',
            'password' => 'Пароль'
        ];
    }

    /**
     * @return array
     */
    public function rules(): array
    {
        return [
            [['email', 'password'], 'required'],
            ['password', 'validatePassword'],
        ];
    }

    /** Метод для валидации поля пароль в форме входа
     *
     * @param $attribute
     * @param $params
     * @return void
     */
    public function validatePassword($attribute, $params): void
    {
        if (!$this->hasErrors()) {
            $user = $this->getUser();
            if (
                !$user || !Yii::$app->security->validatePassword(
                    $this->password,
                    $user->password
                )
            ) {
                $this->addError($attribute, 'Неправильный email или пароль');
            }
        }
    }

    /** Метод получает email пользователя из БД
     *
     * @return Users|null
     */
    public function getUser(): ?Users
    {
        if (null === $this->_user) {
            $this->_user = Users::findOne(['email' => $this->email]);
        }

        return $this->_user;
    }
}
