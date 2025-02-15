#include "MqttTreeItem.h"
#include "MqttTreeModel.h"
#include <QDebug>
#include <QStringList>

#include "MqttTreeType.h"

MqttTreeModel::MqttTreeModel(QObject *parent)
    : QAbstractItemModel(parent)
{
    m_roleNameMapping[TreeModelRoleName] = "topic";
    m_roleNameMapping[TreeModelRoleDescription] = "message";

    QList<QVariant> rootData;
    rootData << "Topic" << "Message";
    m_mqttRootTreeItem = new MqttTreeItem(rootData);
}

MqttTreeModel::~MqttTreeModel()
{
    delete m_mqttRootTreeItem;
}

int MqttTreeModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return static_cast<MqttTreeItem*>(parent.internalPointer())->columnCount();
    else
        return m_mqttRootTreeItem->columnCount();
}

QVariant MqttTreeModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (role != TreeModelRoleName && role != TreeModelRoleDescription)
        return QVariant();

    MqttTreeItem *item = static_cast<MqttTreeItem*>(index.internalPointer());

    return item->data(role - Qt::UserRole - 1);
}

Qt::ItemFlags MqttTreeModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return 0;

    return QAbstractItemModel::flags(index);
}

QVariant MqttTreeModel::headerData(int section, Qt::Orientation orientation,
                               int role) const
{
    if (orientation == Qt::Horizontal && role == Qt::DisplayRole)
        return m_mqttRootTreeItem->data(section);

    return QVariant();
}

QModelIndex MqttTreeModel::index(int row, int column, const QModelIndex &parent)
            const
{
    if (!hasIndex(row, column, parent))
        return QModelIndex();

    MqttTreeItem *parentItem;

    if (!parent.isValid())
        parentItem = m_mqttRootTreeItem;
    else
        parentItem = static_cast<MqttTreeItem*>(parent.internalPointer());

    MqttTreeItem *childItem = parentItem->child(row);
    if (childItem)
        return createIndex(row, column, childItem);
    else
        return QModelIndex();
}

QModelIndex MqttTreeModel::parent(const QModelIndex &index) const
{
    if (!index.isValid())
        return QModelIndex();

    MqttTreeItem *childItem = static_cast<MqttTreeItem*>(index.internalPointer());
    MqttTreeItem *parentItem = childItem->parentItem();

    if (parentItem == m_mqttRootTreeItem)
        return QModelIndex();

    return createIndex(parentItem->row(), 0, parentItem);
}

int MqttTreeModel::rowCount(const QModelIndex &parent) const
{
    MqttTreeItem *parentItem;
    if (parent.column() > 0)
        return 0;

    if (!parent.isValid())
        parentItem = m_mqttRootTreeItem;
    else
        parentItem = static_cast<MqttTreeItem*>(parent.internalPointer());

    return parentItem->childCount();
}

QHash<int, QByteArray> MqttTreeModel::roleNames() const
{
    return m_roleNameMapping;
}

QVariant MqttTreeModel::newMqttMessage(const QString &topic, const QString &message, int position)
{
    MqttTreeType *t = new MqttTreeType(this);
    t->setTopic(topic);
    t->setMessage(message);
    t->setIndentation(position);
    QVariant v;
    v.setValue(t);
    return v;
}

void MqttTreeModel::addTopic(const QString &topic, const QString &message)
{
    if (m_topicsVariant.contains(topic)) {
        m_topicsVariant[topic].value<MqttTreeType*>()->setMessage(message);
        return;
    }
    QList<QVariant> columnData;
    QList<MqttTreeItem*> parents;
    parents << m_mqttRootTreeItem;
    int position = 0;
    QVariant mqttMessage = newMqttMessage(topic, message, position);
    m_topicsVariant[topic] = mqttMessage;
    columnData << mqttMessage;
    // if (position > indentations.last()) {
    //     if (parents.last()->childCount() > 0) {
    //         parents << parents.last()->child(parents.last()->childCount()-1);
    //         indentations << position;
    //     }
    // } else {
    //     while (position < indentations.last() && parents.count() > 0) {
    //         parents.pop_back();
    //         indentations.pop_back();
    //     }
    // }
    emit beginInsertRows(QModelIndex(), 0, 0);
    // Append a new item to the current parent's list of children.
    parents.last()->insert(0, new MqttTreeItem(columnData, parents.last()));
    emit endInsertRows();
}

void MqttTreeModel::clear()
{
    emit beginResetModel();
    m_mqttRootTreeItem->removeAll();
    emit endResetModel();

    for(auto &t: m_topicsVariant){
        delete t.value<MqttTreeType*>();
    }
    m_topicsVariant.clear();
}
